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
  
  String? profilePicture;

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
    final unselectedColor =Colors.white;
    return Padding(
      padding: EdgeInsets.only(bottom: dW * 0.01),
      child: Container(
        height: dH * 0.07,
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
          children: [
            _buildNavItem(0, 'home', isDarkMode, unselectedColor),
            _buildNavItem(1, 'job', isDarkMode, unselectedColor),
            _buildNavItem(2, 'shop', isDarkMode, unselectedColor),
            _buildNavItem(3, 'messages', isDarkMode, unselectedColor),
            _buildProfileNavItem(4, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, String iconName, bool isDarkMode, Color unselectedColor) {
    bool isSelected = _currentIndex == index;

    String iconToUse =  iconName;
    Color iconColor = isSelected
        ? Color(0xff25BAFF)
        : unselectedColor;

    return InkWell(
      onTap: () => onTapped(index),
      child: Container(
        width: dW * 0.15,
        height: dH * 0.05,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: AssetSvgIcon(
            iconToUse,
            height: 24,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileNavItem(int index, bool isDarkMode) {
    bool isSelected = _currentIndex == index;
    double size = 24;

    return InkWell(
      onTap: () => onTapped(index),
      child: Container(
        width: dW * 0.15,
        height: dH * 0.05,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 2,
                    )
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: _buildProfileImage(size),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(double size) {
    const String fallbackUrl = 
        'https://images.unsplash.com/photo-1480455624313-e29b44bbfde1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bWVuJTIwcHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D';

    if (!_isInitialized) {
      return Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.person,
          size: size * 0.7,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
    }

    return Image.network(
      profilePicture ?? fallbackUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Theme.of(context).colorScheme.secondary,
          child: const CircularProgressIndicator(strokeWidth: 2),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.person,
            size: size * 0.7,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        );
      },
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