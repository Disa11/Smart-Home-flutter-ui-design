import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/service/auth_service.dart';
import 'package:flutter_samples_main/samples/smart_home/core/theme/sh_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SHColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Hello Again',
                  style: GoogleFonts.buda(
                    textStyle: TextStyle(
                      color: SHColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              _emailAddress(),
              const SizedBox(height: 20),
              _password(),
              const SizedBox(height: 50),
              _signin(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: SHColors.textColor,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          style: TextStyle(color: SHColors.textColor, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            hintText: 'ejemplo@gmail.com',
            hintStyle: TextStyle(
              color: SHColors.hintColor,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            fillColor: SHColors.cardColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: SHColors.textColor,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          controller: _passwordController,
          style: TextStyle(color: SHColors.textColor, fontSize: 14),
          decoration: InputDecoration(
            hintText: '********',
            hintStyle: TextStyle(color: SHColors.hintColor, fontSize: 14),
            filled: true,
            fillColor: SHColors.cardColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _signin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: SHColors.selectedColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signin(
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
        );
      },
      child: Text(
        "Sign In",
        style: GoogleFonts.montserrat(
          color: SHColors.backgroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

//Estilo Card
/*import 'dart:ui'; // Importante para usar BackdropFilter
import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/service/auth_service.dart';
import 'package:flutter_samples_main/samples/smart_home/core/theme/sh_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SHColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            _backgroundEffects(),
            Center(child: _glassContainer(context)),
          ],
        ),
      ),
    );
  }

  Widget _backgroundEffects() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2C2F34), Color(0xFF3E4249)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _glassContainer(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hello Again',
                  style: GoogleFonts.buda(
                    textStyle: TextStyle(
                      color: SHColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                _emailAddress(),
                const SizedBox(height: 20),
                _password(),
                const SizedBox(height: 40),
                _signin(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: SHColors.textColor, fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          style: TextStyle(color: SHColors.textColor, fontSize: 14),
          decoration: InputDecoration(
            hintText: 'ejemplo@gmail.com',
            hintStyle: TextStyle(color: SHColors.hintColor),
            filled: true,
            fillColor: SHColors.cardColor.withOpacity(0.6),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: SHColors.textColor, fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: true,
          controller: _passwordController,
          style: TextStyle(color: SHColors.textColor, fontSize: 14),
          decoration: InputDecoration(
            hintText: '********',
            hintStyle: TextStyle(color: SHColors.hintColor),
            filled: true,
            fillColor: SHColors.cardColor.withOpacity(0.6),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _signin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: SHColors.selectedColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        minimumSize: const Size(double.infinity, 55),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signin(
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
        );
      },
      child: Text(
        "Sign In",
        style: GoogleFonts.montserrat(
          color: SHColors.backgroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}*/
