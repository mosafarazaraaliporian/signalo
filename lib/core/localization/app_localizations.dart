class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static AppLocalizations of(String languageCode) {
    return AppLocalizations(languageCode);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'SIGNALO',
      'app_subtitle': 'Crypto & Forex Signals',
      
      // Language Selection
      'select_language': 'Select Language',
      'english': 'English',
      'persian': 'فارسی',
      'continue': 'Continue',
      
      // Onboarding
      'onboarding_title_1': 'Real-Time Signals',
      'onboarding_desc_1': 'Get instant crypto and forex trading signals with high accuracy',
      'onboarding_title_2': 'Expert Analysis',
      'onboarding_desc_2': 'Professional market analysis and trading recommendations',
      'onboarding_title_3': 'Track Your Success',
      'onboarding_desc_3': 'Monitor your trades and improve your trading strategy',
      'skip': 'Skip',
      'next': 'Next',
      'get_started': 'Get Started',
      
      // Auth
      'welcome_back': 'Welcome Back!',
      'login_subtitle': 'Sign in to continue trading',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',
      'login': 'Log in',
      'dont_have_account': "Don't have an account?",
      'sign_up': 'Sign up',
      'create_account': 'Create Account',
      'signup_subtitle': 'Start your trading journey',
      'full_name': 'Full Name',
      'confirm_password': 'Confirm Password',
      'already_have_account': 'Already have an account?',
      'or_continue_with': 'Or continue with',
    },
    'fa': {
      'app_name': 'سیگنالو',
      'app_subtitle': 'سیگنال‌های کریپتو و فارکس',
      
      // Language Selection
      'select_language': 'انتخاب زبان',
      'english': 'English',
      'persian': 'فارسی',
      'continue': 'ادامه',
      
      // Onboarding
      'onboarding_title_1': 'سیگنال‌های لحظه‌ای',
      'onboarding_desc_1': 'دریافت سیگنال‌های معاملاتی کریپتو و فارکس با دقت بالا',
      'onboarding_title_2': 'تحلیل حرفه‌ای',
      'onboarding_desc_2': 'تحلیل بازار و پیشنهادات معاملاتی توسط کارشناسان',
      'onboarding_title_3': 'پیگیری موفقیت',
      'onboarding_desc_3': 'معاملات خود را رصد کنید و استراتژی معاملاتی‌تان را بهبود دهید',
      'skip': 'رد شدن',
      'next': 'بعدی',
      'get_started': 'شروع کنید',
      
      // Auth
      'welcome_back': 'خوش آمدید!',
      'login_subtitle': 'برای ادامه وارد شوید',
      'email': 'ایمیل',
      'password': 'رمز عبور',
      'forgot_password': 'فراموشی رمز عبور؟',
      'login': 'ورود',
      'dont_have_account': 'حساب کاربری ندارید؟',
      'sign_up': 'ثبت نام',
      'create_account': 'ایجاد حساب کاربری',
      'signup_subtitle': 'سفر معاملاتی خود را شروع کنید',
      'full_name': 'نام و نام خانوادگی',
      'confirm_password': 'تکرار رمز عبور',
      'already_have_account': 'قبلاً ثبت نام کرده‌اید؟',
      'or_continue_with': 'یا ادامه با',
    },
  };

  String translate(String key) {
    return _localizedValues[languageCode]?[key] ?? key;
  }
}
