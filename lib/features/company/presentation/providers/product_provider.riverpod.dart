import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository/product_repository_provider.riverpod.dart';
import '../../domain/domain.dart';

final productProvider =
    StateNotifierProvider.family<ProductNotifier, ProductState, String>(
        (ref, idProduct) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductNotifier(
    idProduct: idProduct,
    productRepository: productRepository,
  );
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductRepository productRepository;
  ProductNotifier({
    required String idProduct,
    required this.productRepository,
  }) : super(ProductState(id: idProduct)) {
    loadProduct();
  }
  Product newEmptyProduct() {
    return Product(
      idProduct: 'new',
      nameProduct: '',
      brand: '',
      description: '',
      status: false,
      img: '',
      price: 0,
      amount: 0,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      expireProduct: DateTime(2024, DateTime.december, 10, 11, 59),
      idCategory: 0,
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          product: newEmptyProduct(),
        );
        return;
      }
      final product =
          await productRepository.getProductById(idProduct: state.id);
      state = state.copyWith(
        isLoading: false,
        product: product,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}