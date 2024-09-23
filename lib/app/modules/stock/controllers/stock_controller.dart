import 'package:get/get.dart';
import 'package:torani/app/data/service_provider.dart';

class StockController extends GetxController {
  //TODO: Implement StockController

  List listProducts = [];
  RxBool isListProductsExist = false.obs;

  RxInt totalProducts = 0.obs;
  RxInt totalStock = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    var dataProducts = await ServiceProvider().getProducts();
    listProducts = dataProducts[0]["products"];
    print("listproducts: $listProducts");
    totalProducts.value = dataProducts[1]["data"]["total_products"];
    totalStock.value = dataProducts[1]["data"]["total_stock"];
    isListProductsExist.value = true;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
