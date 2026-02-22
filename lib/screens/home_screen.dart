import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final String languageCode;
  
  const HomeScreen({super.key, required this.languageCode});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
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
        child: _buildBody(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        languageCode: widget.languageCode,
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
      case 3:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'Home',
            style: TextStyle(fontSize: 24, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSignalsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'Signals',
            style: TextStyle(fontSize: 24, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'Settings',
            style: TextStyle(fontSize: 24, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'Profile',
            style: TextStyle(fontSize: 24, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
