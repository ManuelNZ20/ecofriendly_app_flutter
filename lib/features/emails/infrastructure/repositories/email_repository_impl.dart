import '../../domain/domain.dart';

class EmailRepositoryImpl implements EmailRepositories {
  final EmailDatasources emailDatasources;

  EmailRepositoryImpl({required this.emailDatasources});

  @override
  Future<void> sendEmailToken({String? email, String? token}) async {
    await emailDatasources.sendEmailToken(
      email: email ?? '',
      token: token ?? '',
    );
  }
}
