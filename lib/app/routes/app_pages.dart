import 'package:get/get.dart';

import '../modules/admin-profile/bindings/admin_profile_binding.dart';
import '../modules/admin-profile/views/admin_profile_view.dart';
import '../modules/alamat/bindings/alamat_binding.dart';
import '../modules/alamat/views/alamat_view.dart';
import '../modules/alamatSaya/bindings/alamat_saya_binding.dart';
import '../modules/alamatSaya/views/alamat_saya_view.dart';
import '../modules/auth-admin/bindings/auth_admin_bindings.dart';
import '../modules/auth-admin/views/auth_admin_view.dart';
import '../modules/consign/bindings/consign_binding.dart';
import '../modules/consign/views/consign_view.dart';
import '../modules/detail_pesanan/bindings/detail_pesanan_binding.dart';
import '../modules/detail_pesanan/views/detail_pesanan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/bindings/register_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/register_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/shope/bindings/shope_binding.dart';
import '../modules/shope/views/shope_view.dart';
import '../modules/transaksi/bindings/transaksi_binding.dart';
import '../modules/transaksi/views/transaksi_view.dart';
// app_pages.dart

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

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
      page: () => ShopeView(),
      binding: ShopeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PROFILE,
      page: () => AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_ADMIN,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.CONSIGN,
      page: () => ConsignView(),
      binding: ConsignBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PESANAN,
      page: () => DetailPesananView(),
      binding: DetailPesananBinding(),
    ),
    GetPage(
      name: _Paths.ALAMAT,
      page: () => AlamatView(),
      binding: AlamatBinding(),
    ),
    GetPage(
      name: _Paths.ALAMAT_SAYA,
      page: () => AlamatSayaView(),
      binding: AlamatSayaBinding(),
    ),

  ];
}
