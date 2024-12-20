// app_routes.dart
part of 'app_pages.dart';

abstract class Routes {
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER; // Tambahkan rute register
  static const TRANSAKSI = _Paths.TRANSAKSI;
  static const SHOPE = _Paths.SHOPE;
  static const PROFILE = _Paths.PROFILE;
  static const NAVBAR = _Paths.NAVBAR;
  static const AUTH_ADMIN = _Paths.AUTH_ADMIN;
  static const ADMIN_PROFILE = _Paths.ADMIN_PROFILE;
  static const CONSIGN = _Paths.CONSIGN;
  static const DETAIL_PESANAN = _Paths.DETAIL_PESANAN;
  static const ALAMAT = _Paths.ALAMAT;
  static const ALAMAT_SAYA = _Paths.ALAMAT_SAYA;
}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register'; // Tambahkan path register
  static const TRANSAKSI = '/transaksi';
  static const SHOPE = '/shope';
  static const PROFILE = '/profile';
  static const NAVBAR = '/navbar';
  static const AUTH_ADMIN = '/auth-admin';
  static const ADMIN_PROFILE = '/admin-profile';
  static const CONSIGN = '/consign';
  static const DETAIL_PESANAN = '/detail-pesanan';
  static const ALAMAT = '/alamat';
  static const ALAMAT_SAYA = '/alamat-saya';
}
