import 'package:ecofriendly_app/features/company/domain/repositories/company_app_respository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/domain.dart';
import 'repository/company_app_repository.riverpod.dart';

final companiesProvider =
    StateNotifierProvider<CompaniesNotifier, CompaniesState>((ref) {
  final companyAppRepository = ref.watch(companyAppRepositoryProvider);
  return CompaniesNotifier(companyAppRepository: companyAppRepository);
});

class CompaniesNotifier extends StateNotifier<CompaniesState> {
  final CompanyAppRespository companyAppRepository;
  CompaniesNotifier({
    required this.companyAppRepository,
  }) : super(CompaniesState()) {
    loadCompanies();
  }

  Future<void> loadCompanies() async {
    try {
      state = state.copyWith(
        companies: [],
      );
      if (state.isLoading) return;
      state = state.copyWith(
        isLoading: true,
      );
      final companies = await companyAppRepository.getCompanies();
      if (companies.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        companies: companies,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> updatedCompany(
    String id,
    String imgPresentation,
    String bannerCompany,
    String nameCompany,
    String descriptionCompany,
    String location,
    String ruc,
    String address,
    String phone,
    String email,
    String urlWeb,
    String urlFacebook,
    String urlInstagram,
  ) async {
    try {
      final company = await companyAppRepository.updateDataCompany(
        id,
        imgPresentation,
        bannerCompany,
        nameCompany,
        descriptionCompany,
        location,
        ruc,
        address,
        phone,
        email,
        urlWeb,
        urlFacebook,
        urlInstagram,
      );
      state = state.copyWith(
        companies: state.companies
            .map((e) => (e.idCompany == id) ? company : e)
            .toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

class CompaniesState {
  final bool isLastPage;
  final int limit;
  final int offSet;
  final bool isLoading;
  final List<CompanyApp> companies;

  CompaniesState({
    this.isLastPage = false,
    this.limit = 0,
    this.offSet = 0,
    this.isLoading = false,
    this.companies = const [],
  });

  CompaniesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offSet,
    bool? isLoading,
    List<CompanyApp>? companies,
  }) =>
      CompaniesState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offSet: offSet ?? this.offSet,
        isLoading: isLoading ?? this.isLoading,
        companies: companies ?? this.companies,
      );
}
