import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final String languageCode;
  
  const OnboardingScreen({super.key, required this.languageCode});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AppLocalizations _localizations;

  @override
  void initState() {
    super.initState();
    _localizations = AppLocalizations.of(widget.languageCode);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPage(
        title: _localizations.translate('onboarding_title_1'),
        description: _localizations.translate('onboarding_desc_1'),
      ),
      _buildPage(
        title: _localizations.translate('onboarding_title_2'),
        description: _localizations.translate('onboarding_desc_2'),
      ),
      _buildPage(
        title: _localizations.translate('onboarding_title_3'),
        description: _localizations.translate('onboarding_desc_3'),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: pages,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 32 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? Colors.black : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  
                  // Get started button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < 2) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(languageCode: widget.languageCode),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage < 2
                            ? _localizations.translate('next')
                            : _localizations.translate('get_started'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  if (_currentPage < 2) SizedBox(height: 16),
                  
                  // Log in button
                  if (_currentPage < 2)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(languageCode: widget.languageCode),
                            ),
                          );
                        },
                        child: Text(
                          _localizations.translate('login'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for illustration
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                Icons.image_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
            ),
          ),
          
          SizedBox(height: 60),
          
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: 16),
          
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
