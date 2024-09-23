import 'package:get/get.dart';

import '../controllers/take_stock_controller.dart';

class TakeStockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TakeStockController>(
      () => TakeStockController(),
    );
  }
}
