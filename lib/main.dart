import 'package:bluecs_assignment/common_widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home_Module/providers/post_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider()),
        // Add other providers here if you have them
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Modern teal/cyan theme based on the screenshot
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00BCD4), // Cyan/Teal primary
            brightness: Brightness.dark,
            primary: const Color(0xFF00BCD4),
            secondary: const Color(0xFF4DD0E1),
            surface: const Color(0xFF23303D),
            background: const Color(0xFF121212),
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onBackground: Colors.white,
          ),
          
          // App Bar Theme
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF161F28),
            foregroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          // Bottom Navigation Bar Theme
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF161F28),
            selectedItemColor: Color(0xFF00BCD4),
            unselectedItemColor: Color(0xFF666666),
            type: BottomNavigationBarType.fixed,
          ),
          
          // Card Theme
          cardTheme: CardTheme(
            color: const Color(0xFF2A2A2A),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          
          // Elevated Button Theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BCD4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          
          // Text Button Theme
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF00BCD4),
            ),
          ),
          
          // Input Decoration Theme
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF2A2A2A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF444444)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF444444)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF00BCD4), width: 2),
            ),
            hintStyle: const TextStyle(color: Color(0xFF888888)),
            labelStyle: const TextStyle(color: Color(0xFF00BCD4)),
          ),
          
          // Text Theme
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            titleMedium: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            titleSmall: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            bodySmall: TextStyle(
              color: Color(0xFF888888),
              fontSize: 12,
            ),
          ),
          
          // Icon Theme
          iconTheme: const IconThemeData(
            color: Color(0xFF00BCD4),
            size: 24,
          ),
          
          // Chip Theme
          chipTheme: ChipThemeData(
            backgroundColor: const Color(0xFF2A2A2A),
            selectedColor: const Color(0xFF00BCD4),
            labelStyle: const TextStyle(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          
          // Floating Action Button Theme
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF00BCD4),
            foregroundColor: Colors.white,
          ),
          
          // Switch Theme
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(0xFF00BCD4);
              }
              return const Color(0xFF666666);
            }),
            trackColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(0xFF00BCD4).withOpacity(0.5);
              }
              return const Color(0xFF333333);
            }),
          ),
          
          // Progress Indicator Theme
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF00BCD4),
          ),
          
          // Divider Theme
          dividerTheme: const DividerThemeData(
            color: Color(0xFF333333),
            thickness: 1,
          ),
        ),
        home: BottomNavBar(),
      ),
    );
  }
}