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

}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register'; // Tambahkan path register
  static const TRANSAKSI = '/transaksi';
  static const SHOPE = '/shope';
  static const PROFILE = '/profile';
  static const NAVBAR = '/navbar';
}
