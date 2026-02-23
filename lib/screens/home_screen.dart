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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AppLocalizations _localizations;
  late bool _isDarkMode;
  late String _languageCode;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _localizations = AppLocalizations.of(widget.languageCode);
    _isDarkMode = widget.isDarkMode;
    _languageCode = widget.languageCode;
    
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: _isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: _isDarkMode ? Color(0xFF0A0015) : Colors.white,
        systemNavigationBarIconBrightness: _isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isDarkMode
                ? [Color(0xFF0A0015), Color(0xFF1A0B2E), Color(0xFF2D1B4E)]
                : [Colors.white, Color(0xFFFAF5FF), Color(0xFFF5F0FF)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: _buildBody(),
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

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildSignalsTab();
      case 2:
        return _buildSettingsTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    final isRTL = _languageCode == 'fa';
    final textColor = _isDarkMode ? Colors.white : Color(0xFF1A1F36);
    
    return Column(
      children: [
        // Animated Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFF9D4EDD), Color(0xFF7B2CBF), Color(0xFF5A189A)],
                    ).createShader(bounds),
                    child: Text(
                      'Signalo',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  _buildIconButton(Icons.telegram, () {}),
                  SizedBox(width: 10.w),
                  _buildIconButton(Icons.notifications_none_rounded, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationsScreen(isDarkMode: _isDarkMode),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: 10.h),
        
        // Stories
        StoryList(isDarkMode: _isDarkMode),
        
        SizedBox(height: 24.h),
        
        // Main Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                _buildStatsCard(isRTL, textColor),
                SizedBox(height: 16.h),
                _buildQuickActionsCard(isRTL, textColor),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 46.w,
          height: 46.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isDarkMode
                  ? [
                      Colors.white.withValues(alpha: 0.15),
                      Colors.white.withValues(alpha: 0.05),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.9),
                      Colors.white.withValues(alpha: 0.6),
                    ],
            ),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: _isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isDarkMode
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
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

  Widget _buildStatsCard(bool isRTL, Color textColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isDarkMode
                  ? [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.9),
                      Colors.white.withValues(alpha: 0.6),
                    ],
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: _isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE91E63), Color(0xFFFF6B9D)],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE91E63).withValues(alpha: 0.4),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(Icons.trending_up_rounded, color: Colors.white, size: 28.sp),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          isRTL ? 'سیگنال‌های امروز' : 'Today\'s Signals',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: textColor.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '12',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('85%', isRTL ? 'موفق' : 'Success', Color(0xFF10B981)),
                  _buildStatItem('24', isRTL ? 'فعال' : 'Active', Color(0xFF9D4EDD)),
                  _buildStatItem('156', isRTL ? 'کل' : 'Total', Color(0xFF3B82F6)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: _isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsCard(bool isRTL, Color textColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isDarkMode
                  ? [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.9),
                      Colors.white.withValues(alpha: 0.6),
                    ],
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: _isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isRTL ? 'دسترسی سریع' : 'Quick Actions',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(Icons.add_chart_rounded, isRTL ? 'سیگنال' : 'Signal'),
                  _buildActionButton(Icons.analytics_outlined, isRTL ? 'تحلیل' : 'Analysis'),
                  _buildActionButton(Icons.history_rounded, isRTL ? 'تاریخچه' : 'History'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9D4EDD), Color(0xFF7B2CBF)],
            ),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF9D4EDD).withValues(alpha: 0.4),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 28.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: _isDarkMode ? Colors.white70 : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSignalsTab() {
    return Center(child: Text('Signals', style: TextStyle(color: Colors.white)));
  }

  Widget _buildSettingsTab() {
    final isRTL = _languageCode == 'fa';
    final textColor = _isDarkMode ? Colors.white : Color(0xFF1A1F36);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isRTL ? 'تنظیمات' : 'Settings',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w900,
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
              activeColor: Color(0xFF9D4EDD),
            ),
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
              style: TextStyle(color: _isDarkMode ? Colors.white : Color(0xFF1A1F36), fontSize: 14.sp),
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
    required bool isRTL,
  }) {
    final textColor = _isDarkMode ? Colors.white : Color(0xFF1A1F36);
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isDarkMode
                  ? [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.9),
                      Colors.white.withValues(alpha: 0.6),
                    ],
            ),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: _isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
          ),
          child: Row(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFFF6B9D)],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 14.w),
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
