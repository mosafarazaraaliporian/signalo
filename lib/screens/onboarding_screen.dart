import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../core/localization/app_localizations.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final String languageCode;
  final bool isDarkMode;
  
  const OnboardingScreen({
    super.key,
    required this.languageCode,
    required this.isDarkMode,
  });

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
    ScreenUtil.init(context, designSize: Size(375, 812));
    
    final bgColor = widget.isDarkMode ? Color(0xFF1A1A1A) : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black;
    final subtextColor = widget.isDarkMode ? Colors.grey[400] : Colors.grey[600];
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: widget.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: bgColor,
        systemNavigationBarIconBrightness: widget.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    final pages = [
      _buildPage(
        title: _localizations.translate('onboarding_title_1'),
        description: _localizations.translate('onboarding_desc_1'),
        textColor: textColor,
        subtextColor: subtextColor!,
      ),
      _buildPage(
        title: _localizations.translate('onboarding_title_2'),
        description: _localizations.translate('onboarding_desc_2'),
        textColor: textColor,
        subtextColor: subtextColor,
      ),
      _buildPage(
        title: _localizations.translate('onboarding_title_3'),
        description: _localizations.translate('onboarding_desc_3'),
        textColor: textColor,
        subtextColor: subtextColor,
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor,
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
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: WormEffect(
                      dotColor: widget.isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      activeDotColor: textColor,
                      dotHeight: 8.h,
                      dotWidth: 8.w,
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
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
                              builder: (context) => AuthScreen(
                                languageCode: widget.languageCode,
                                isDarkMode: widget.isDarkMode,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: textColor,
                        foregroundColor: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _localizations.translate('next'),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
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
    required Color textColor,
    required Color subtextColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Icon(
                Icons.show_chart_rounded,
                size: 80.sp,
                color: widget.isDarkMode ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
          ),
          
          SizedBox(height: 48.h),
          
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: subtextColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
