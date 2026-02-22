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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                
                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF00d4ff),
                        Color(0xFF0099ff),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.show_chart,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                
                SizedBox(height: 30),
                
                Text(
                  _isLogin
                      ? _localizations.translate('welcome_back')
                      : _localizations.translate('create_account'),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 8),
                
                Text(
                  _isLogin
                      ? _localizations.translate('login_subtitle')
                      : _localizations.translate('signup_subtitle'),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 40),
                
                // Form
                if (!_isLogin)
                  _buildTextField(
                    label: _localizations.translate('full_name'),
                    icon: Icons.person_outline,
                  ),
                
                if (!_isLogin) SizedBox(height: 16),
                
                _buildTextField(
                  label: _localizations.translate('email'),
                  icon: Icons.email_outlined,
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  label: _localizations.translate('password'),
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                
                if (!_isLogin) SizedBox(height: 16),
                
                if (!_isLogin)
                  _buildTextField(
                    label: _localizations.translate('confirm_password'),
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),
                
                if (_isLogin) SizedBox(height: 12),
                
                if (_isLogin)
                  Align(
                    alignment: widget.languageCode == 'fa' 
                        ? Alignment.centerLeft 
                        : Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        _localizations.translate('forgot_password'),
                        style: TextStyle(
                          color: Color(0xFF00d4ff),
                        ),
                      ),
                    ),
                  ),
                
                SizedBox(height: 24),
                
                // Login/Signup Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement authentication
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00d4ff),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _isLogin
                          ? _localizations.translate('login')
                          : _localizations.translate('sign_up'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Toggle Login/Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLogin
                          ? _localizations.translate('dont_have_account')
                          : _localizations.translate('already_have_account'),
                      style: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? _localizations.translate('sign_up')
                            : _localizations.translate('login'),
                        style: TextStyle(
                          color: Color(0xFF00d4ff),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 30),
                
                // Social Login
                Text(
                  _localizations.translate('or_continue_with'),
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(Icons.g_mobiledata, () {}),
                    SizedBox(width: 16),
                    _buildSocialButton(Icons.apple, () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white60),
          prefixIcon: Icon(icon, color: Color(0xFF00d4ff)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
