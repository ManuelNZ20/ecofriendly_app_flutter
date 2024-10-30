import 'package:ecofriendly_app/features/auth/domain/entities/company_app.dart';
import 'package:ecofriendly_app/features/company/domain/repositories/company_app_respository.dart';
import 'package:ecofriendly_app/features/company/presentation/providers/repository/company_app_repository.riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listCompaniesProvider = FutureProvider<List<CompanyApp>>((ref) async {
  final repository = ref.watch(companyAppRepositoryProvider);
  return repository.getCompanies();
});

final companyProvider = StateNotifierProvider.family
    .autoDispose<CompanyNotifier, CompanyState, String>((ref, idCompany) {
  final companyAppRespository = ref.watch(companyAppRepositoryProvider);
  return CompanyNotifier(
    idCompany: idCompany,
    companyAppRespository: companyAppRespository,
  );
});

class CompanyNotifier extends StateNotifier<CompanyState> {
  final CompanyAppRespository companyAppRespository;
  CompanyNotifier({
    required String idCompany,
    required this.companyAppRespository,
  }) : super(CompanyState(id: idCompany)) {
    loadCompany();
  }

  Future<void> loadCompany() async {
    try {
      final company = await companyAppRespository.getDataCompanyById(state.id);

      state = state.copyWith(
        isLoading: false,
        company: company,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class CompanyState {
  final String id;
  final CompanyApp? company;
  final bool isLoading;
  final bool isSaving;

  CompanyState({
    required this.id,
    this.company,
    this.isLoading = true,
    this.isSaving = false,
  });

  CompanyState copyWith({
    String? id,
    CompanyApp? company,
    bool? isLoading,
    bool? isSaving,
  }) =>
      CompanyState(
        id: id ?? this.id,
        company: company ?? this.company,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
