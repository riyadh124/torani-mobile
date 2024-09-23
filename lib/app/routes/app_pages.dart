import 'package:get/get.dart';

import '../modules/detailStock/bindings/detail_stock_binding.dart';
import '../modules/detailStock/views/detail_stock_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/stock/bindings/stock_binding.dart';
import '../modules/stock/views/stock_view.dart';
import '../modules/tabDecider/bindings/tab_decider_binding.dart';
import '../modules/tabDecider/views/tab_decider_view.dart';
import '../modules/takeStock/bindings/take_stock_binding.dart';
import '../modules/takeStock/views/take_stock_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.STOCK,
      page: () => StockView(),
      binding: StockBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.TAB_DECIDER,
      page: () => TabDeciderView(),
      binding: TabDeciderBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_STOCK,
      page: () => DetailStockView(),
      binding: DetailStockBinding(),
    ),
    GetPage(
      name: _Paths.TAKE_STOCK,
      page: () => TakeStockView(),
      binding: TakeStockBinding(),
    ),
  ];
}
