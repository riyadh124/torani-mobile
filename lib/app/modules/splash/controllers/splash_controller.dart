import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:torani/app/modules/home/views/home_view.dart';
import 'package:torani/app/modules/login/views/login_view.dart';
import 'package:torani/app/modules/tabDecider/views/tab_decider_view.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashscreenController

  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    var token = box.read("token");
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (token == null) {
          Get.off(() => LoginView());
        } else {
          Get.off(() => TabDeciderView());
        }
      },
    );
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
