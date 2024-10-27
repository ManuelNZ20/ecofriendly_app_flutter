import 'package:ecofriendly_app/features/company/domain/domain.dart';
import 'package:ecofriendly_app/features/company/infrastructure/datasources/inventory_datasources_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/infrastructure.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepositoryImpl(
      inventoryDatasource: InventoryDatasourcesImpl());
});
