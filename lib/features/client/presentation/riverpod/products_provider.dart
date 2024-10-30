import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product_client.dart';
import '../../domain/repositories/product_client_repository.dart';
import 'repository/product_repository_provider.dart';

final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductsNotifier(productRepository: productRepository);
});

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductClientRepository productRepository;

  ProductsNotifier({required this.productRepository}) : super(ProductsState()) {
    loadProducts();
  }

  Future<int> getAmountProducts() async {
    final amount = await productRepository.getAmountProducts();
    return amount;
  }

  List<ProductClient> getProducts() {
    return state.products;
  }

  List<ProductClient> getProductsWithDiscount() {
    return state.products
        .where((element) => element.productDiscount != null)
        .toList();
  }

  ProductClient getProduct({String id = ''}) {
    // buscar productps de la lista de productos
    return state.products.firstWhere((element) => element.idProduct == id);
  }

  List<ProductClient> getProductsByIdCategory({int idCategory = 0}) {
    // buscar productps de la lista de productos
    return state.products
        .where((element) => element.idCategory == idCategory)
        .toList();
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

  void toggleFavorite(String id) {
    state = state.copyWith(
        products: state.products.map((e) {
      if (e.idProduct == id) {
        return e.copyWith(
          isFavorite: !e.isFavorite!,
        );
      }
      return e;
    }).toList());
  }
}

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<ProductClient> products;

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
    List<ProductClient>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
