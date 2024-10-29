import 'package:ecofriendly_app/core/shared/infrastructure/infrastructure.dart';
import 'package:ecofriendly_app/features/auth/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/infrastructure/infrastructure.dart';

final getCompanyDataProvider = FutureProvider<CompanyApp>((ref) async {
  final supabase = Supabase.instance.client;
  final keyValueStorage = KeyValueStorageImpl();
  final idCompany = await keyValueStorage.getValue<String>('id');
  final res = await supabase
      .from('company_app')
      .select()
      .eq('id', idCompany!)
      .limit(1)
      .single();
  final companyModel = CompanyModel.fromJson(res);
  final company = CompanyAppMapper.companyJsonToEntity(companyModel);
  return company;
});
