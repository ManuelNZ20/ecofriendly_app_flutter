import 'dart:async';
import 'package:bcrypt/bcrypt.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../emails/domain/domain.dart';
import '../../../emails/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final supabase = Supabase.instance.client;
  @override
  Future<UserApp> checkAuthStateAccount(String? otp) {
    throw UnimplementedError();
  }

  @override
  Future<UserApp> checkAuthStatus(String? token) {
    throw UnimplementedError();
  }

  @override
  Future<Session?> getSessionSupabase() {
    throw UnimplementedError();
  }

  @override
  bool isLoggedIn() {
    throw UnimplementedError();
  }

  @override
  StreamSubscription<AuthState> listenToAuthStatus() {
    throw UnimplementedError();
  }

  @override
  Future<UserApp> login(String email, String password) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final userMetadata = res.session?.user.userMetadata;
      if (userMetadata == null) {
        throw Exception('User Metadata is null');
      }
      final userModel = UserModel.fromJson(userMetadata);
      final user = UserAppMapper.userJsonToEntity(userModel);
      return user;
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        throw CustomError(e.message, e.code!);
      }
      if (e.statusCode == '401') {
        throw CustomError('Credenciales Incorrectas', e.code!);
      }
      throw CustomError('Something wrong happend', e.code ?? '');
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Future<UserApp> signUp(
      String email, String password, String name, String lastName) async {
    try {
      final response = await _signUpUser(
        email: email,
        password: password,
        name: name,
        lastName: lastName,
      );
      final data = response;
      if (data.isEmpty) {
        throw CustomError('No se puede registrar al usuario', '500');
      }
      final userModel = UserModel.fromJson(data);
      final userApp = UserAppMapper.userJsonToEntity(userModel);
      return userApp;
    } on CustomError catch (e) {
      throw CustomError('No se puede registrar, ${e.message}', '500');
    } on Exception catch (e) {
      throw Exception('Error al registrarse usuario $e');
    }
  }

  @override
  Future<CompanyApp> signUpCompany(
      String email, String password, String nameCompany, String phone) async {
    try {
      final response = await _signUpCompany(
        email: email,
        password: password,
        name: nameCompany,
        phone: phone,
      );
      final data = response;
      if (data.isEmpty) {
        throw CustomError('No se puede registrar esta cuenta', '500');
      }
      final companyModel = CompanyModel.fromJson(data);
      final companyApp = CompanyAppMapper.companyJsonTiEntity(companyModel);
      return companyApp;
    } on CustomError catch (e) {
      throw CustomError('No se puede registrar, ${e.message}', '500');
    } on Exception catch (e) {
      throw Exception('Error al registrarse usuario $e');
    }
  }

  @override
  Future<UserApp> checkUserOtp(String otp1, String otp2, String otp3,
      String otp4, String otp5, String otp6, String email) async {
    try {
      final token = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
      final res = await _validToken(email, token, 'user_app');
      if (res.isEmpty) {
        throw CustomError('El token es invalido', '500');
      }
      await supabase.from('user_app').update({
        'state_user_account': true,
      }).eq('email', email);
      final userModel = UserModel.fromJson(res.first);
      final userApp = UserAppMapper.userJsonToEntity(userModel);
      return userApp;
    } on CustomError catch (e) {
      throw CustomError('No se puede registrar, ${e.message}', '500');
    } on Exception catch (e) {
      throw Exception('Error al registrarse $e');
    }
  }

  @override
  Future<CompanyApp> checkCompanyOtp(String otp1, String otp2, String otp3,
      String otp4, String otp5, String otp6, String email) async {
    try {
      final token = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
      final res = await _validToken(email, token, 'company_app');
      if (res.isEmpty) {
        throw CustomError('El token es invalido', '500');
      }
      await supabase.from('company_app').update({
        'state_account': true,
      }).eq('email', email);
      final companyModel = CompanyModel.fromJson(res.first);
      final companyApp = CompanyAppMapper.companyJsonTiEntity(companyModel);
      return companyApp;
    } on CustomError catch (e) {
      throw CustomError('No se puede registrar, ${e.message}', '500');
    } on Exception catch (e) {
      throw Exception('Error al registrarse $e');
    }
  }

  Future<Map<String, dynamic>> _signUpUser({
    String email = '',
    String password = '',
    String name = '',
    String lastName = '',
  }) async {
    try {
      final detectedEmailCompany =
          await _detectedEmail(email, true, 'company_app');
      final detectedEmailUser = await _detectedEmail(email, true, 'user_app');
      if (detectedEmailCompany || detectedEmailUser) {
        throw CustomError('Este correo electronico ya existe', '500');
      }
      final token = const Uuid().v4().substring(0, 6);
      final EmailRepositories sendEmail =
          EmailRepositoryImpl(emailDatasources: EmailDatasourceImpl());
      sendEmail.sendEmailToken(
        email: email,
        token: token,
      );
      final hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());

      final resp = await supabase.from('user_app').insert({
        'email': email,
        'password': hashPassword,
        'name': name,
        'last_name': lastName,
        'token_state_account': token,
        'id_type_user': 1,
      }).select();
      return resp.first;
    } on CustomError catch (e) {
      throw CustomError(e.message, '500');
    } on Exception catch (e) {
      throw Exception(
          'Error durante la solicitud de registro: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> _signUpCompany({
    String email = '',
    String password = '',
    String name = '',
    String phone = '',
  }) async {
    try {
      final detectedEmailCompany =
          await _detectedEmail(email, true, 'company_app');
      final detectedEmailUser = await _detectedEmail(email, true, 'user_app');
      if (detectedEmailCompany || detectedEmailUser) {
        throw CustomError('Este correo electronico ya existe', '500');
      }
      final token = const Uuid().v4().substring(0, 6);
      final EmailRepositories sendEmail =
          EmailRepositoryImpl(emailDatasources: EmailDatasourceImpl());
      sendEmail.sendEmailToken(
        email: email,
        token: token,
      );
      final hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());
      print('$name, $email,$phone');
      final resp = await supabase.from('company_app').insert({
        'email': email,
        'password': hashPassword,
        'name_company': name,
        'phone': phone,
        'token_state_account': token,
        'id_type_user': 1,
      }).select();
      return resp.first;
    } on CustomError catch (e) {
      throw CustomError(e.message, '500');
    } on Exception catch (e) {
      throw Exception(
          'Error durante la solicitud de registro: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> _validToken(
      String email, String token, String table) async {
    final res = await supabase
        .from(table)
        .select()
        .eq('email', email)
        .eq('token_state_account', token);
    return res;
  }

  Future<bool> _detectedEmail(
      String email, bool stateAccount, String table) async {
    final detectedEmail = await supabase
        .from(table)
        .select()
        .eq('email', email)
        .eq('state_account', stateAccount);
    return detectedEmail.isNotEmpty;
  }
}
