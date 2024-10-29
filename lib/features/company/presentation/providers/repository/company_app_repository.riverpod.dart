import 'package:ecofriendly_app/features/company/domain/domain.dart';
import 'package:ecofriendly_app/features/company/infrastructure/datasources/company_app_datasources_impl.dart';
import 'package:ecofriendly_app/features/company/infrastructure/repositories/company_app_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final companyAppRepositoryProvider = Provider<CompanyAppRespository>((ref) {
  final companyRepository = CompanyAppRepositoryImpl(
      companyAppDatasource: CompanyAppDatasourcesImpl());
  return companyRepository;
});
