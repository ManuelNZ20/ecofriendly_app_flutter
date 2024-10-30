class ProductClientDiscount {
  final String idproductdiscount;
  final String idproduct;
  final double discountpercentage; //discount_percentage
  final DateTime createdAt; //created_at

  ProductClientDiscount({
    required this.idproductdiscount,
    required this.idproduct,
    required this.discountpercentage,
    required this.createdAt,
  });
}
