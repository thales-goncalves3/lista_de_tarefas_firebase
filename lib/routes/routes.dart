import 'package:flutter/material.dart';

import '../pages/create_task_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    "/login_page": (context) => const LoginPage(),
    "/register_page": (context) => const RegisterPage(),
    "/home_page": (context) => const HomePage(),
    "/create_task_page": (context) => const CreateTask(),
  };

  static String initial = "/";

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
