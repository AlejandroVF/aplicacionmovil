import 'package:get/route_manager.dart';
import 'package:proyecto/pages/depto_page.dart';
import 'package:proyecto/pages/home_page.dart';
import 'package:proyecto/pages/login_page.dart';
import 'package:proyecto/pages/register_login_page.dart';

routes() => [
  GetPage(name: "/home", page: () => HomePage()),
  GetPage(name: "/registration", page: () => RegisterLoginPage()),
  GetPage(name: "/loginpage", page: () => LoginPage()),
  GetPage(name: "/logingoogle", page: () => LoginPage()),
  GetPage(
      name: "/deptopage",
      page: () => DeptoPage(),
      transition: Transition.zoom),
];