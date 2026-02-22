import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import '../core/localization/app_localizations.dart';
import '../core/services/theme_service.dart';
import '../core/services/language_service.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/story_list.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  final String languageCode;
  final bool isDarkMode;
  
  const HomeScreen({
    super.key,
    required this.languageCode,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late AppLocalizations _localizations;
  late bool _isDarkMode;
  late String _languageCode;

  @override
  void initState() {
    super.initState();
    _localizations = AppLocalizations.of(widget.languageCode);
    _isDarkMode = widget.isDarkMode;
    _languageCode = widget.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));
    
    final bgColor = _isDarkMode ? Color(0xFF0A0E27) : Color(0xFFF5F7FA);
    final textColor = _isDarkMode ? Colors.white : Color(0xFF1A1F36);
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: _isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Color(0xFF2D2D2D),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isDarkMode
                ? [Color(0xFF0A0E27), Color(0xFF1A1F36), Color(0xFF2D3561)]
                : [Color(0xFFF5F7FA), Color(0xFFE8EAF6), Color(0xFFD1D9E6)],
          ),
        ),
        child: SafeArea(
          child: _buildBody(textColor),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        languageCode: _languageCode,
        isDarkMode: _isDarkMode,
      ),
    );
  }

  Widget _buildBody(Color textColor) {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab(textColor);
      case 1:
        return _buildSignalsTab(textColor);
      case 2:
        return _buildSettingsTab(textColor);
      default:
        return _buildHomeTab(textColor);
    }
  }

  Widget _buildHomeTab(Color textColor) {
    final isRTL = _languageCode == 'fa';
    
    return Column(
      children: [
        // Glass Header
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isDarkMode
                      ? [
                          Colors.white.withValues(alpha: 0.1),
                          Colors.white.withValues(alpha: 0.05),
                        ]
                      : [
                          Colors.white.withValues(alpha: 0.7),
                          Colors.white.withValues(alpha: 0.3),
                        ],
                ),
                border: Border(
                  bottom: BorderSide(
                    color: _isDarkMode
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.white.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFFE91E63), Color(0xFFFF6B9D)],
                    ).createShader(bounds),
                    child: Text(
                      'Signalo',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildGlassButton(
                        icon: Icons.telegram,
                        onPressed: () {},
                      ),
                      SizedBox(width: 8.w),
                      _buildGlassButton(
                        icon: Icons.notifications_outlined,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationsScreen(isDarkMode: _isDarkMode),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
        
        StoryList(isDarkMode: _isDarkMode),
        
        SizedBox(height: 20.h),
        
        Expanded(
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isDarkMode
                          ? [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.05),
                            ]
                          : [
                              Colors.white.withValues(alpha: 0.7),
                              Colors.white.withValues(alpha: 0.3),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: _isDarkMode
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart_rounded,
                        size: 64.sp,
                        color: Color(0xFFE91E63),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        isRTL ? 'سیگنال‌ها' : 'Signals',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isDarkMode
                  ? [
                      Colors.white.withValues(alpha: 0.15),
                      Colors.white.withValues(alpha: 0.05),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.8),
                      Colors.white.withValues(alpha: 0.4),
                    ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: IconButton(
            icon: Icon(icon, color: _isDarkMode ? Colors.white : Color(0xFF1A1F36), size: 22.sp),
            onPressed: onPressed,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildSignalsTab(Color textColor) {
    final isRTL = _languageCode == 'fa';
    
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isDarkMode
                    ? [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.05),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.7),
                        Colors.white.withValues(alpha: 0.3),
                      ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: _isDarkMode
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.show_chart_rounded,
                  size: 64.sp,
                  color: Color(0xFFE91E63),
                ),
                SizedBox(height: 12.h),
                Text(
                  isRTL ? 'سیگنال‌ها' : 'Signals',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTab(Color textColor) {
    final isRTL = _languageCode == 'fa';
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isRTL ? 'تنظیمات' : 'Settings',
            textAlign: isRTL ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          
          SizedBox(height: 24.h),
          
          _buildGlassSettingItem(
            icon: Icons.person_outline_rounded,
            title: isRTL ? 'پروفایل' : 'Profile',
            trailing: Icon(
              isRTL ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: textColor.withValues(alpha: 0.5),
              size: 18.sp,
            ),
            textColor: textColor,
            isRTL: isRTL,
          ),
          
          SizedBox(height: 12.h),
          
          _buildGlassSettingItem(
            icon: Icons.dark_mode_outlined,
            title: isRTL ? 'حالت شب' : 'Dark Mode',
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) async {
                await ThemeService.setDarkMode(value);
                setState(() {
                  _isDarkMode = value;
                });
              },
              activeColor: Color(0xFFE91E63),
            ),
            textColor: textColor,
            isRTL: isRTL,
          ),
          
          SizedBox(height: 12.h),
          
          _buildGlassSettingItem(
            icon: Icons.language_outlined,
            title: isRTL ? 'زبان' : 'Language',
            trailing: DropdownButton<String>(
              value: _languageCode,
              underline: SizedBox(),
              dropdownColor: _isDarkMode ? Color(0xFF2D3561) : Colors.white,
              style: TextStyle(color: textColor, fontSize: 14.sp),
              items: [
                DropdownMenuItem(value: 'fa', child: Text('فارسی')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (value) async {
                if (value != null) {
                  await LanguageService.setLanguage(value);
                  setState(() {
                    _languageCode = value;
                    _localizations = AppLocalizations.of(value);
                  });
                }
              },
            ),
            textColor: textColor,
            isRTL: isRTL,
          ),
        ],
      ),
    );
  }

  Widget _buildGlassSettingItem({
    required IconData icon,
    required String title,
    required Widget trailing,
    required Color textColor,
    required bool isRTL,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isDarkMode
                  ? [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.7),
                      Colors.white.withValues(alpha: 0.3),
                    ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: _isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFFF6B9D)],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
