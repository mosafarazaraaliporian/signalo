import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    
    final bgColor = _isDarkMode ? Color(0xFF1A1A1A) : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black;
    
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
      body: SafeArea(
        child: _buildBody(textColor),
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
      case 3:
        return _buildProfileTab(textColor);
      default:
        return _buildHomeTab(textColor);
    }
  }

  Widget _buildHomeTab(Color textColor) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Signalo',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: textColor, size: 24.sp),
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
        ),
        
        StoryList(isDarkMode: _isDarkMode),
        
        SizedBox(height: 16.h),
        
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.show_chart_rounded,
                  size: 64.sp,
                  color: _isDarkMode ? Colors.grey[700] : Colors.grey[300],
                ),
                SizedBox(height: 12.h),
                Text(
                  'Signals will appear here',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: _isDarkMode ? Colors.grey[600] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignalsTab(Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.show_chart_rounded,
            size: 64.sp,
            color: _isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          SizedBox(height: 12.h),
          Text(
            'Signals',
            style: TextStyle(
              fontSize: 18.sp,
              color: _isDarkMode ? Colors.grey[600] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab(Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings_rounded,
            size: 64.sp,
            color: _isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          SizedBox(height: 12.h),
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 18.sp,
              color: _isDarkMode ? Colors.grey[600] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab(Color textColor) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          
          SizedBox(height: 24.h),
          
          _buildSettingItem(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) async {
                await ThemeService.setDarkMode(value);
                setState(() {
                  _isDarkMode = value;
                });
              },
              activeColor: Colors.black,
            ),
            textColor: textColor,
          ),
          
          SizedBox(height: 12.h),
          
          _buildSettingItem(
            icon: Icons.language_outlined,
            title: 'Language',
            trailing: DropdownButton<String>(
              value: _languageCode,
              underline: SizedBox(),
              dropdownColor: _isDarkMode ? Color(0xFF2D2D2D) : Colors.white,
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
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Widget trailing,
    required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
