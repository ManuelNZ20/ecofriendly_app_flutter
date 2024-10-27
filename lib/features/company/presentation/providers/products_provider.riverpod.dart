import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared/infrastructure/service/cloudinary_init.service.riverpod.dart';
import 'repository/product_repository_provider.riverpod.dart';
import '../../domain/domain.dart';

final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductsNotifier(productRepository: productRepository);
});

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductRepository productRepository;

  ProductsNotifier({required this.productRepository}) : super(ProductsState()) {
    loadProducts();
  }

  Future<int> getAmountProducts() async {
    final amount = await productRepository.getAmountProducts();
    return amount;
  }

  Future<List<Product>> getProductsOutstanding() async {
    final products = await productRepository.getProductsOutstanding();
    return products;
  }

  Future<void> getProductsOutstandingStark() async {
    final products = await productRepository.getProductsOutstanding();
    state = state.copyWith(
      products: products,
    );
  }

  Stream<List<Product>> getProductsStream() {
    final products = productRepository.getProductsStream();
    return products;
  }

  Future<bool> existingProductWithDiscount(String idproduct) async {
    try {
      final product = await productRepository.getProductWithDiscountById(
          idproduct: idproduct);
      if (product == null) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> loadProducts() async {
    try {
      state = state.copyWith(
        products: [],
      );
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);
      final products = await productRepository.getProducts();
      if (products.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        products: products,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<bool> createdOrUpdatedProduct(
    String idProduct,
    String nameProduct,
    String brand,
    String description,
    bool status,
    String img,
    double price,
    int amount,
    DateTime createAt,
    DateTime updateAt,
    DateTime expireProduct,
    int idCategory,
  ) async {
    try {
      if (idProduct == 'new') {
        final imgPath =
            await CloudinaryInit.uploadImage(img, UploadPreset.product);
        final product = await productRepository.createProduct(
          nameProduct: nameProduct,
          brand: brand,
          description: description,
          status: status,
          img: imgPath,
          price: price,
          amount: amount,
          expireProduct: expireProduct,
          idCategory: idCategory,
        );
        state = state.copyWith(
          products: [...state.products, product],
        );
        return true;
      }
      final existingProduct = state.products
          .firstWhere((element) => element.idProduct == idProduct);
      final bool hasImageChange = existingProduct.img != img;
      String updatedImgPath = img;

      if (hasImageChange) {
        // Subir imagen nueva y asignarla a `updatedImgPath`
        updatedImgPath =
            await CloudinaryInit.uploadImage(img, UploadPreset.product);
      }
      // Actualizar producto con la imagen cargada (si hubo cambio)
      final product = await productRepository.updateProduct(
        idProduct: idProduct,
        nameProduct: nameProduct,
        brand: brand,
        description: description,
        status: status,
        img: updatedImgPath, // URL de la nueva imagen
        price: price,
        amount: amount,
        updateAt: updateAt,
        expireProduct: expireProduct,
        idCategory: idCategory,
      );

      state = state.copyWith(
        products: state.products
            .map((e) => (e.idProduct == idProduct) ? product : e)
            .toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit = 10,
    int? offset = 0,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
