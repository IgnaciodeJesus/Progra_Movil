import 'package:get/get.dart';
import '../../models/entities/Producto.dart';
import '../../services/product_service.dart';

class CandySelectionController extends GetxController {
  RxList<Producto> products = <Producto>[].obs;
  RxMap<Producto, int> selectedProducts = <Producto, int>{}.obs;
  final ProductService productService = ProductService();
  RxDouble candyPrice = 0.0.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    var productsData = await productService.fetchProducts();
    products.assignAll(productsData);
  }

  void addToTotal(Producto product) {
    if (selectedProducts.containsKey(product)) {
      selectedProducts[product] = selectedProducts[product]! + 1;
    } else {
      selectedProducts[product] = 1;
    }
    updateCandyTotal();
  }

  void removeFromTotal(Producto product) {
    if (selectedProducts.containsKey(product) &&
        selectedProducts[product]! > 0) {
      selectedProducts[product] = selectedProducts[product]! - 1;
    }
    updateCandyTotal();
  }

  void updateCandyTotal() {
    candyPrice.value = selectedProducts.entries
        .map((entry) => entry.key.precio * entry.value)
        .fold(0.0, (previous, current) => previous + current);
  }

  double get grandTotal => candyPrice.value;
}
