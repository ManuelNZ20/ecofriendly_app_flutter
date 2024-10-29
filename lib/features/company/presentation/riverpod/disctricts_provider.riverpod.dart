import 'package:ecofriendly_app/core/shared/infrastructure/mappers/disctrict_mapper.dart';
import 'package:ecofriendly_app/core/shared/infrastructure/models/district.module.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecofriendly_app/core/shared/domain/entities/district.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final districtsProvider = FutureProvider<List<District>>((ref) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from('districts')
      .select('''id,name_districts,capital,id_provinces''');
  final listModel = response
      .map(
        (e) => DistrictModel.fromJson(e),
      )
      .toList();
  final districts = listModel
      .map(
        (e) => DistrictMapper.toDistrictEntity(e),
      )
      .toList();
  return districts;
});
