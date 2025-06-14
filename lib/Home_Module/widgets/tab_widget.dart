import 'package:flutter/material.dart';

class ResponsiveTabsWidget extends StatefulWidget {
  const ResponsiveTabsWidget({super.key});

  @override
  State<ResponsiveTabsWidget> createState() => _ResponsiveTabsWidgetState();
}

class _ResponsiveTabsWidgetState extends State<ResponsiveTabsWidget> {
  int selectedIndex = 0;
  
  final List<String> tabs = [
    'All Posts',
    'Videos',
    'Short Videos',
    'Near',
  ];

  @override
  Widget build(BuildContext context) {
    // Get display metrics for responsive design
    final mediaQuery = MediaQuery.of(context);
    final pixelRatio = mediaQuery.devicePixelRatio;
    final screenWidth = mediaQuery.size.width;
    
    // Calculate responsive dimensions based on pixel ratio
    final baseHeight = 35.0;
    final basePadding = 12.0;
    final baseRadius = 20.0;
    final baseFontSize = 14.0;
    
    // Adjust dimensions based on pixel ratio for consistent appearance
    final adjustedHeight = baseHeight * (pixelRatio > 2.5 ? 1.1 : 1.0);
    final adjustedPadding = basePadding * (pixelRatio > 2.5 ? 1.1 : 1.0);
    final adjustedRadius = baseRadius * (pixelRatio > 2.5 ? 1.1 : 1.0);
    final adjustedFontSize = baseFontSize * (pixelRatio > 2.5 ? 1.05 : 1.0);
    
    return Container(
      height: adjustedHeight,
      padding: EdgeInsets.symmetric(horizontal: adjustedPadding * 0.5), // Reduced horizontal padding
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final isSelected = selectedIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < tabs.length - 1 ? 8.0 * (pixelRatio > 2.5 ? 1.1 : 1.0) : 0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        height: adjustedHeight,
                        padding: EdgeInsets.symmetric(
                          horizontal: adjustedPadding,
                          vertical: 2.0 * (pixelRatio > 2.5 ? 1.1 : 1.0),
                        ),
                        decoration: BoxDecoration(
                          color: isSelected 
                            ? const Color(0xFF09A8D3).withOpacity(0.25) // Blue color for selected
                            : Colors.transparent,
                          borderRadius: BorderRadius.circular(adjustedRadius),
                          border: Border.all(
                            color: isSelected 
                              ? const Color(0xFF25BAFF) 
                              : const Color(0xFF4A5568), // Dark gray border
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: isSelected 
                                ? Colors.white 
                                : const Color(0xFFE2E8F0), // Light gray text
                              fontSize: adjustedFontSize,
                              fontWeight: isSelected 
                                ? FontWeight.w500 
                                : FontWeight.w400,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}