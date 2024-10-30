import 'package:ecofriendly_app/features/client/domain/entities/entities.dart';

abstract class ProductClientRepository {
  Future<ProductClient> getProductById({String idProduct = ''});

  Future<ProductClient?> getProductWithDiscountById({String idproduct = ''});

  Future<List<ProductClient>> getProducts();

  Future<List<ProductClient>> getProductsOutstanding();

  Future<int> getAmountProducts();

  Future<List<ProductClient>> searchProducts(String textSearch);

  Stream<List<ProductClient>> searchProductsStream(String textSearch);

  Stream<List<ProductClient>> getProductsStream();

  Future<List<ProductClient>> getProductsByCategory(String idCategory);

  Future<List<ProductClient>> getProductsWithDiscount();
}
