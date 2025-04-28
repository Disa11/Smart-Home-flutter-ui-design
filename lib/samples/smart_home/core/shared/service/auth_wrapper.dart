import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/service/auth_service.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/domain/entities/sample.dart';
import 'package:ui_common/ui_common.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    _handleAuth();
  }

  Future<void> _handleAuth() async {
    bool isAuthenticated = await AuthService().checkAuth(context: context);
    print('isAuthenticated: $isAuthenticated');
    if (isAuthenticated) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Sample.smartHome.route,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Sample.loginPage.route,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:
          (_, __) =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
