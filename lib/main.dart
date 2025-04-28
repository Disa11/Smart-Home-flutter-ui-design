import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples_main/samples/smart_home/core/app/app.dart';
import 'package:flutter_samples_main/firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'test-flutter-9981e',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SmartHomeApp());
}
