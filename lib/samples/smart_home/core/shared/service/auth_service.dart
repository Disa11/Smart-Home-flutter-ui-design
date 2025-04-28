import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/domain/entities/sample.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Navegar a la página principal
      Navigator.pushNamed(context, Sample.smartHome.route);
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.code}");
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid credential provided.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for this email.';
      } else if (e.code == 'user-disabled') {
        message = 'User account has been disabled.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Operation not allowed.';
      } else {
        message = 'An unknown error occurred.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    //print(checkAuth(context: context));
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  bool checkAuth({required BuildContext context}) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Navegar a la página principal
      Navigator.pushNamed(context, Sample.smartHome.route);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'email-already-in-use') {
        message = 'Email already in use.';
      } else if (e.code == 'weak-password') {
        message = 'Weak password provided.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
