import 'package:ecofriendly_app/core/shared/infrastructure/infrastructure.dart';
import 'package:ecofriendly_app/features/auth/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final companyProvider = FutureProvider<CompanyApp>((ref) async {
  final supabase = Supabase.instance.client;
  final keyValueStorage = KeyValueStorageImpl();
  final idCompany = await keyValueStorage.getValue<String>('id');
  print(idCompany);
  final res = await supabase
      .from('company_app')
      .select()
      .eq('id', idCompany!)
      .limit(1)
      .single();
  print(res);
  return CompanyApp(
    idCompany: res['id'] ?? '',
    imgPresentation: res['img_presentation'] ?? '',
    bannerCompany: res['banner_company'] ?? '',
    nameCompany: res['name_company'] ?? '',
    accountCreated: res['create_at'] ?? '',
    description: res['description'] ?? '',
    location: res['location'] ?? '',
    ruc: res['ruc'] ?? '',
    address: res['address'] ?? '',
    phone: res['phone'] ?? '',
    email: res['email'] ?? '',
    idDistrict: res['id_district'] ?? '',
    password: res['password'] ?? '',
    urlWeb: res['url_web'],
    urlFacebook: res['url_facebook'] ?? '',
    urlInstagram: res['url_instagram'] ?? '',
    accountStatus: res['state_account'] ?? '',
    tokenAuth: res['token_auth'] ?? '',
    tokenStateAccount: res['token_state_account'] ?? '',
  );
});
