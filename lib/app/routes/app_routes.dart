// app_routes.dart
part of 'app_pages.dart';

abstract class Routes {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register'; // Tambahkan rute register
  static const TRANSAKSI = '/transaksi';
  static const SHOPE = _Paths.SHOPE;
}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register'; // Tambahkan path register
  static const TRANSAKSI = '/transaksi';
  static const SHOPE = '/shope';
}
