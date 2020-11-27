
import 'package:get/get.dart';
import 'package:hos/login/login.dart';

import '../dashboard.dart';
class Routers {
  static final route = [
    GetPage(
      name: '/loginpage',
      page: () => login(),
    ),
    GetPage(
      name: '/Dashboard',
      page: () => Dashboard(),
    ),
  ];
}