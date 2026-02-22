import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../core/services/language_service.dart';
import '../core/services/theme_service.dart';
import 'language_selection_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _shimmerController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
    
    Timer(const Duration(seconds: 2), () async {
      final isLanguageSelected = await LanguageService.isLanguageSelected();
      
      if (!mounted) return;
      
      if (isLanguageSelected) {
        final languageCode = await LanguageService.getLanguage();
        final isDark = await ThemeService.isDarkMode();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingScreen(
              languageCode: languageCode,
              isDarkMode: isDark,
            ),
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
  void dispose() {
    _controller.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0A0015),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0015),
              Color(0xFF1A0B2E),
              Color(0xFF2D1B4E),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: AnimatedBuilder(
                animation: _shimmerController,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [
                          Color(0xFFFFD700),
                          Color(0xFFFFE55C),
                          Color(0xFFFFD700),
                          Color(0xFF9D4EDD),
                          Color(0xFF7B2CBF),
                          Color(0xFF5A189A),
                        ],
                        stops: [
                          _shimmerController.value - 0.3,
                          _shimmerController.value - 0.2,
                          _shimmerController.value - 0.1,
                          _shimmerController.value,
                          _shimmerController.value + 0.1,
                          _shimmerController.value + 0.2,
                        ].map((e) => e.clamp(0.0, 1.0)).toList(),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      'Signalo',
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -1.5,
                        shadows: [
                          Shadow(
                            color: Color(0xFF9D4EDD).withOpacity(0.5),
                            blurRadius: 30,
                          ),
                          Shadow(
                            color: Color(0xFFFFD700).withOpacity(0.3),
                            blurRadius: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
