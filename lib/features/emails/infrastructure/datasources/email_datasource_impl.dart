import 'package:dio/dio.dart';
import 'package:ecofriendly_app/core/core.dart';

import '../../../auth/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';

class EmailDatasourceImpl implements EmailDatasources {
  final dio = Dio();
  @override
  Future<void> sendEmailToken({String? email, String? token}) async {
    final headers = {
      'Authorization': 'Bearer ${Environment.apiKeyResend}',
      'Content-Type': 'application/json',
    };
    final data = {
      'from': 'Ecofriendly <${Environment.emailSender}>',
      'to': [email],
      'subject': 'Verificación de Token',
      'html': '''
              <h2>Hola EcoAlido!</h2>
              <p>Para ultimar detalles con tu registro se te ha enviado un token de acceso</p>
              <h3><b>Token: </b>$token</h3>
              ''',
    };
    try {
      await dio.post(
        'https://api.resend.com/emails',
        options: Options(
          headers: headers,
        ),
        data: data,
      );
    } on EmailErrors catch (e) {
      throw EmailErrors(
          'No se logro enviar el correo electronico ${e.toString()}');
    }
  }
}
