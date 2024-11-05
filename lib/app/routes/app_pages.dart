import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/bindings/register_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/register_view.dart';
import '../modules/shope/bindings/shope_binding.dart';
import '../modules/shope/views/shope_view.dart';
import '../modules/transaksi/bindings/transaksi_binding.dart';
import '../modules/transaksi/views/transaksi_view.dart';

// app_pages.dart

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TRANSAKSI;

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
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI,
      page: () => TransaksiView(),
      binding: TransaksiBinding(),
    ),
    GetPage(
      name: _Paths.SHOPE,
      page: () => const ShopeView(),
      binding: ShopeBinding(),
    ),
  ];
}
