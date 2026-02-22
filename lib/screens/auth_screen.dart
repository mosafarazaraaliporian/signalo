import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/localization/app_localizations.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  final String languageCode;
  final bool isDarkMode;
  
  const AuthScreen({
    super.key,
    required this.languageCode,
    required this.isDarkMode,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  late AppLocalizations _localizations;

  @override
  void initState() {
    super.initState();
    _localizations = AppLocalizations.of(widget.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));
    
    final bgColor = widget.isDarkMode ? Color(0xFF1A1A1A) : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black;
    final subtextColor = widget.isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final fieldBg = widget.isDarkMode ? Colors.grey[850] : Colors.grey[100];
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: widget.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: bgColor,
        systemNavigationBarIconBrightness: widget.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      
                      Text(
                        _isLogin
                            ? _localizations.translate('welcome_back')
                            : _localizations.translate('create_account'),
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      
                      SizedBox(height: 8.h),
                      
                      Text(
                        _isLogin
                            ? _localizations.translate('login_subtitle')
                            : _localizations.translate('signup_subtitle'),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: subtextColor,
                        ),
                      ),
                      
                      SizedBox(height: 32.h),
                      
                      if (!_isLogin)
                        _buildTextField(
                          label: _localizations.translate('full_name'),
                          fieldBg: fieldBg!,
                          textColor: textColor,
                        ),
                      
                      if (!_isLogin) SizedBox(height: 12.h),
                      
                      _buildTextField(
                        label: _localizations.translate('email'),
                        fieldBg: fieldBg!,
                        textColor: textColor,
                      ),
                      
                      SizedBox(height: 12.h),
                      
                      _buildTextField(
                        label: _localizations.translate('password'),
                        isPassword: true,
                        fieldBg: fieldBg,
                        textColor: textColor,
                      ),
                      
                      if (!_isLogin) SizedBox(height: 12.h),
                      
                      if (!_isLogin)
                        _buildTextField(
                          label: _localizations.translate('confirm_password'),
                          isPassword: true,
                          fieldBg: fieldBg,
                          textColor: textColor,
                        ),
                      
                      if (_isLogin) SizedBox(height: 8.h),
                      
                      if (_isLogin)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              _localizations.translate('forgot_password'),
                              style: TextStyle(
                                color: textColor,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              languageCode: widget.languageCode,
                              isDarkMode: widget.isDarkMode,
                            ),
                          ),
                        );
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
                        _isLogin
                            ? _localizations.translate('login')
                            : _localizations.translate('sign_up'),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 12.h),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textColor,
                        side: BorderSide(color: textColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Text(
                        _isLogin
                            ? _localizations.translate('sign_up')
                            : _localizations.translate('login'),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool isPassword = false,
    required Color fieldBg,
    required Color textColor,
  }) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: textColor, fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: widget.isDarkMode ? Colors.grey[500] : Colors.grey[600],
          fontSize: 14.sp,
        ),
        filled: true,
        fillColor: fieldBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: textColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }
}
