import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples_main/samples/smart_home/core/theme/sh_theme.dart';
//import 'package:flutter_samples_main/samples/smart_home/features/home/presentation/screens/home_screen.dart';
import 'package:ui_common/ui_common.dart';
import 'package:flutter_samples_main/samples/smart_home/core/routes/routes.dart';

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );
    // Conflicto presentado por el uso de dos MaterialApp
    // en el mismo proyecto, uno para la app principal y otro para la app de ejemplo
    // Esto causó conflictos en las rutas y en el tema de la app
    // Solución: usar ScreenUtilInit para inicializar la app de ejemplo
    // y evitar conflictos con el MaterialApp principal
    // Se eliminó el uso de ScreenUtilInit en la app principal
    return ScreenUtilInit(
      builder:
          (_, child) => MaterialApp(
            title: 'Smart Home App',
            debugShowCheckedModeBanner: false,
            theme: SHTheme.dark,
            //home: child,
            routes: AppRoutes.routes,
          ),
      //child: const HomeScreen(),
    );
  }
}
