import 'package:flutter/cupertino.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/domain/entities/sample.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/login/login_screen.dart';
import 'package:flutter_samples_main/samples/smart_home/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/service/auth_wrapper.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => AuthWrapper(),
    Sample.smartHome.route: (context) => const HomeScreen(),
    Sample.loginPage.route: (context) => Login(),
  };
}
