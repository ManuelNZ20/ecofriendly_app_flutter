import 'package:ecofriendly_app/features/client/domain/entities/entities.dart';

abstract class BannerClientRepository {
  Future<List<BannerClient>> getBanners();
  Future<BannerClient> getBannerById({String id});

  Stream<List<BannerClient>> getBannersStream();
}
