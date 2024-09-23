import 'package:get/get.dart';
import 'package:torani/app/data/service_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List listStocks = [];
  RxBool isListStocksExist = false.obs;

  var totalStock;
  RxString totalStockIn = "".obs;
  RxString totalStockOut = "".obs;
  RxBool isTotalStockInExist = false.obs;
  RxBool isTotalStockOutExist = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    totalStock = await ServiceProvider().getStockCounts();
    print("totalStock: $totalStock");
    totalStockIn.value = totalStock["total_stock_in"];
    isTotalStockInExist.value = true;
    totalStockOut.value = totalStock["total_stock_out"];
    isTotalStockOutExist.value = true;

    listStocks = await ServiceProvider().getStocks();
    isListStocksExist.value = true;
    print("listStocks : $listStocks");
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
