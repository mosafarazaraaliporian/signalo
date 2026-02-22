import 'package:flutter/material.dart';
import 'dart:async';
import '../core/services/language_service.dart';
import 'language_selection_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 2), () async {
      final isLanguageSelected = await LanguageService.isLanguageSelected();
      
      if (!mounted) return;
      
      if (isLanguageSelected) {
        final languageCode = await LanguageService.getLanguage();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingScreen(languageCode: languageCode),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LanguageSelectionScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Signalo',
          style: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}
