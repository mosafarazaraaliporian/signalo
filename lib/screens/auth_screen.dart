import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  final String languageCode;
  
  const AuthScreen({super.key, required this.languageCode});

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      
                      // Title
                      Text(
                        _isLogin
                            ? _localizations.translate('welcome_back')
                            : _localizations.translate('create_account'),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      
                      SizedBox(height: 8),
                      
                      Text(
                        _isLogin
                            ? _localizations.translate('login_subtitle')
                            : _localizations.translate('signup_subtitle'),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      
                      SizedBox(height: 40),
                      
                      // Form
                      if (!_isLogin)
                        _buildTextField(
                          label: _localizations.translate('full_name'),
                        ),
                      
                      if (!_isLogin) SizedBox(height: 16),
                      
                      _buildTextField(
                        label: _localizations.translate('email'),
                      ),
                      
                      SizedBox(height: 16),
                      
                      _buildTextField(
                        label: _localizations.translate('password'),
                        isPassword: true,
                      ),
                      
                      if (!_isLogin) SizedBox(height: 16),
                      
                      if (!_isLogin)
                        _buildTextField(
                          label: _localizations.translate('confirm_password'),
                          isPassword: true,
                        ),
                      
                      if (_isLogin) SizedBox(height: 12),
                      
                      if (_isLogin)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              _localizations.translate('forgot_password'),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              
              // Bottom buttons
              Column(
                children: [
                  // Main button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _isLogin
                            ? _localizations.translate('login')
                            : _localizations.translate('sign_up'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Secondary button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.black, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        _isLogin
                            ? _localizations.translate('sign_up')
                            : _localizations.translate('login'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
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
  }) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
