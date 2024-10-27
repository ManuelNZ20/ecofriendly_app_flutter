import '../entities/product_discount.dart';

abstract class ProductDiscountDatasource {
  Future<List<ProductDiscount>> getProductsDiscount();

  Future<ProductDiscount?> getProductDiscountById({
    String idproduct = '',
  });

  Future<ProductDiscount> createProductDiscount({
    String idproduct,
    double discountPercentage,
  });

  Future<ProductDiscount> updateProductDiscount({
    String idproductdiscount,
    String idproduct,
    double discountPercentage,
  });
  Stream<List<ProductDiscount>> getProductsStream();
}
