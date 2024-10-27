import '../../domain/domain.dart';
import '../models/product_discount.module.dart';

class ProductDiscountMapper {
  static ProductDiscount toProductEntity(
          ProductDiscountModel productDiscount) =>
      ProductDiscount(
        idproductdiscount: productDiscount.idproductdiscount,
        idproduct: productDiscount.idproduct,
        discountpercentage: productDiscount.discountPercentage,
        createdAt: productDiscount.createdAt,
        product: productDiscount.product,
      );
}
