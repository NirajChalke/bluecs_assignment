import 'package:bluecs_assignment/Home_Module/screens/home.dart';
import 'package:flutter/material.dart';

import 'assetSvgIcon.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> with WidgetsBindingObserver {
  int _currentIndex = 0;
  double dW = 0;
  double dH = 0;
  double tS = 0;

  bool _showNotificationScreen = false;
  bool _showFollowRequestScreen = false;
  bool _isInitialized = false;
  bool _isDisposed = false;
  bool _isInitializing = false; // Prevent multiple initialization calls

  late List<Widget?> _children;
  
  String profilePicture= 'assets/images/profile.jpg';

  // Navigation items with labels
  final List<NavigationItem> _navigationItems = [
    NavigationItem(iconName: 'home', label: 'Home'),
    NavigationItem(iconName: 'job', label: 'Jobs'),
    NavigationItem(iconName: 'shop', label: 'Shop'),
    NavigationItem(iconName: 'messages', label: 'Messages'),
    NavigationItem(iconName: 'profile', label: 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeScreens();
    // Use addPostFrameCallback to ensure initialization happens after build
  
  }

  @override
  void dispose() {
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _initializeScreens() {
    _children = List.filled(5, null);
    // Only initialize essential screens immediately
    _children[0] = HomeScreen();
   
    // Other screens will be lazy-loaded
  }

 
  void onTapped(int index) {
    if (_isDisposed) return;
    
    setState(() {
      _currentIndex = index;
      _showNotificationScreen = false;
      _showFollowRequestScreen = false;

      // Lazy load screens with null safety
      if (_children[index] == null) {
        _children[index] = _buildScreen(index);
      }
    });
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      // case 1:
      //   return const SearchScreen();
      // case 2:
      //   return AddpostScreen(onClose: () => onTapped(0));
      // case 3:
      //   return const TapeScreen();
      // case 4:
      //   return const CurrentUserProfileScreen();
      default:
        return const Center(child: Text('Screen not found'));
    }
  }

  void showNotificationScreen() {
    if (_isDisposed) return;
    
    setState(() {
      _showNotificationScreen = !_showNotificationScreen;
      _showFollowRequestScreen = false;
    });
  }

  void showFollowRequestScreen() {
    if (_isDisposed) return;
    
    setState(() {
      _showFollowRequestScreen = !_showFollowRequestScreen;
    });
  }

  Widget _buildCustomBottomNavigation() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final unselectedColor = Colors.white;
    
    return Padding(
      padding: EdgeInsets.only(bottom: dW * 0.01),
      child: Container(
        height: dH * 0.085, // Increased height to accommodate labels
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_navigationItems.length, (index) {
            if (index == 4) {
              return _buildProfileNavItem(index, isDarkMode);
            }
            return _buildNavItem(index, _navigationItems[index], isDarkMode, unselectedColor);
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, NavigationItem navItem, bool isDarkMode, Color unselectedColor) {
    bool isSelected = _currentIndex == index;

    Color iconColor = isSelected ? Color(0xff25BAFF) : unselectedColor;
    Color textColor = isSelected ? Color(0xff25BAFF) : unselectedColor;

    return InkWell(
      onTap: () => onTapped(index),
      child: Container(
        width: dW * 0.15,
        height: dH * 0.07,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AssetSvgIcon(
              navItem.iconName,
              height: 20, // Slightly smaller to make room for text
              color: iconColor,
            ),
            SizedBox(height: 2),
            Text(
              navItem.label,
              style: TextStyle(
                color: textColor,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileNavItem(int index, bool isDarkMode) {
    bool isSelected = _currentIndex == index;
    double size = 20; // Slightly smaller to make room for text
    Color textColor = isSelected ? Color(0xff25BAFF) : Colors.white;

    return InkWell(
      onTap: () => onTapped(index),
      child: Container(
        width: dW * 0.15,
        height: dH * 0.07,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), // Rounded corners instead of circle
                border: isSelected
                    ? Border.all(
                        color: Color(0xff25BAFF),
                        width: 2,
                      )
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6), // Match the container border radius
                child: _buildProfileImage(size),
              ),
            ),
            SizedBox(height: 2),
            Text(
              _navigationItems[4].label,
              style: TextStyle(
                color: textColor,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(double size) {
    const String fallbackUrl = 
        'https://images.unsplash.com/photo-1480455624313-e29b44bbfde1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bWVuJTIwcHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D';


    return Image.asset(
      profilePicture,
      fit: BoxFit.cover,

    );
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    dH = MediaQuery.of(context).size.height;
    tS = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _children.map((e) => e ?? const Center(child: CircularProgressIndicator())).toList(),
          ),

        ],
      ),
      bottomNavigationBar:
          _currentIndex != 2 ? _buildCustomBottomNavigation() : null,
    );
  }
}

// Helper class to organize navigation items
class NavigationItem {
  final String iconName;
  final String label;

  NavigationItem({required this.iconName, required this.label});
}