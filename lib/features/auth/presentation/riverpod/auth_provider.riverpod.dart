import 'package:ecofriendly_app/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecofriendly_app/features/auth/domain/domain.dart';

import '../../infrastructure/errors/auth_errors.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(
    authRepository: authRepository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({
    required this.authRepository,
  }) : super(AuthState());

  Future<void> loginUser(
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout(errorMessage: 'Credenciales no son correctas');
    } on ConnectionTimeout {
      logout(errorMessage: 'No cuenta con conexión a internet');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } catch (e) {
      logout(errorMessage: 'Error no controlado, $e');
    }
  }

  Future<void> register(
    String email,
    String password,
    String name,
    String lastName,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.signUp(
        email,
        password,
        name,
        lastName,
      );
      _setLoggedUser(user);
      state = state.copyWith(messageRegister: 'Datos Comfirmados');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  Future<void> registerCompany(
      String email, String password, String nameCompany, String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final company = await authRepository.signUpCompany(
        email,
        password,
        nameCompany,
        phone,
      );
      _setLoggedCompany(company);
      state = state.copyWith(messageRegister: 'Datos Comfirmados');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  Future<void> otpUser(String otp1, String otp2, String otp3, String otp4,
      String otp5, String otp6, String email) async {
    try {
      final user = await authRepository.checkUserOtp(
          otp1, otp2, otp3, otp4, otp5, otp6, email);
      _setLoggedUser(user);
      state = state.copyWith(messageRegister: 'Registro Exitoso');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  Future<void> otpCompany(String otp1, String otp2, String otp3, String otp4,
      String otp5, String otp6, String email) async {
    try {
      final company = await authRepository.checkCompanyOtp(
          otp1, otp2, otp3, otp4, otp5, otp6, email);
      _setLoggedCompany(company);
      state = state.copyWith(messageRegister: 'Registro Exitoso');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  void checkAuthStatus() async {
    final session = await authRepository.getSessionSupabase();
    if (session == null) return logout();
    try {
      final user = await authRepository.checkAuthStatus(session.refreshToken);
      _setLoggedUser(user);
    } catch (e) {
      logout(errorMessage: 'CheckAuthStatus');
    }
  }

  void _setLoggedUser(UserApp user) async {
    state = state.copyWith(
      user: user,
      company: null,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
      messageRegister: '',
    );
  }

  void _setLoggedCompany(CompanyApp company) async {
    state = state.copyWith(
      company: company,
      user: null,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
      messageRegister: '',
    );
  }

  Future<void> logout({String? errorMessage}) async {
    state = state.copyWith(
      authStatus: AuthStatus.noAuthenticated,
      user: null,
      company: null,
      errorMessage: errorMessage ?? '',
      messageRegister: '',
    );
    authRepository.signOut();
  }
}

enum AuthStatus {
  checking,
  authenticated,
  noAuthenticated,
  verifyRegister,
}

class AuthState {
  final AuthStatus authStatus;
  final UserApp? user;
  final CompanyApp? company;
  final String errorMessage;
  final String messageRegister;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.company,
    this.errorMessage = '',
    this.messageRegister = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    UserApp? user,
    CompanyApp? company,
    String? errorMessage,
    String? messageRegister,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        company: company ?? this.company,
        errorMessage: errorMessage ?? this.errorMessage,
        messageRegister: messageRegister ?? this.messageRegister,
      );
}
