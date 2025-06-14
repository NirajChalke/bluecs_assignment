// Enhanced Stories Section with responsive design
import 'package:flutter/material.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions and device pixel ratio
    final screenWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Calculate responsive dimensions
    final horizontalMargin = screenWidth * 0.04; // 4% of screen width
    final verticalMargin = screenHeight * 0.01; // 1% of screen height
    final storyHeight = screenHeight * 0.25; // 25% of screen height
    final storyWidth = screenWidth * 0.35; // 35% of screen width
    final spaceBetweenStories = screenWidth * 0.03; // 3% of screen width
    
    // Responsive font sizes based on screen width
    final usernameFontSize = (screenWidth * 0.03).clamp(10.0, 14.0);
    final badgeFontSize = (screenWidth * 0.02).clamp(6.0, 10.0);
    
    // Responsive profile picture size
    final profilePictureSize = (screenWidth * 0.08).clamp(24.0, 36.0);
    
    // Responsive border width based on device pixel ratio
    final borderWidth = (2.0 / devicePixelRatio).clamp(1.0, 3.0);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stories Grid
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.012),
            child: SizedBox(
              height: storyHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _getStoriesData().length,
                itemBuilder: (context, index) {
                  final story = _getStoriesData()[index];
                  return Container(
                    width: storyWidth,
                    margin: EdgeInsets.only(right: spaceBetweenStories),
                    child: GestureDetector(
                      onTap: () => _handleStoryTap(context, story),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            (screenWidth * 0.03).clamp(8.0, 16.0),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            (screenWidth * 0.025).clamp(8.0, 12.0),
                          ),
                          child: Stack(
                            children: [
                              // Background Image
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                                child: Image.network(
                                  story['imageUrl'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[800],
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size: profilePictureSize * 1.2,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              
                              // Profile Picture
                              Positioned(
                                top: screenHeight * 0.01,
                                left: screenWidth * 0.02,
                                child: Container(
                                  width: profilePictureSize,
                                  height: profilePictureSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: borderWidth,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      story['profileImageUrl'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[600],
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: profilePictureSize * 0.5,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Username
                              Positioned(
                                bottom: screenHeight * 0.01,
                                left: screenWidth * 0.02,
                                right: screenWidth * 0.02,
                                child: Text(
                                  story['username'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: usernameFontSize,
                                    fontWeight: FontWeight.w600,
                                    shadows: const [
                                      Shadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              
                              // Story Type Indicator
                              if (story['storyType'] != null)
                                Positioned(
                                  top: screenHeight * 0.01,
                                  right: screenWidth * 0.02,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.015,
                                      vertical: screenHeight * 0.003,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStoryTypeColor(story['storyType']),
                                      borderRadius: BorderRadius.circular(
                                        (screenWidth * 0.02).clamp(6.0, 10.0),
                                      ),
                                    ),
                                    child: Text(
                                      _getStoryTypeText(story['storyType']),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: badgeFontSize,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getStoriesData() {
    return [
      {
        'id': '1',
        'username': 'sarah_chef',
        'imageUrl': 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=300&h=400&fit=crop',
        'profileImageUrl': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=64&h=64&fit=crop&crop=face',
        'hasNewStory': true,
        'storyType': 'food',
      },
      {
        'id': '2',
        'username': 'beauty_guru',
        'imageUrl': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=300&h=400&fit=crop',
        'profileImageUrl': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=64&h=64&fit=crop&crop=face',
        'hasNewStory': true,
        'storyType': 'beauty',
      },
      {
        'id': '3',
        'username': 'makeup_pro',
        'imageUrl': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300&h=400&fit=crop',
        'profileImageUrl': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=64&h=64&fit=crop&crop=face',
        'hasNewStory': true,
        'storyType': 'beauty',
      },
      {
        'id': '4',
        'username': 'style_expert',
        'imageUrl': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300&h=400&fit=crop',
        'profileImageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=64&h=64&fit=crop&crop=face',
        'hasNewStory': false,
        'storyType': 'fashion',
      },
      {
        'id': '5',
        'username': 'travel_diary',
        'imageUrl': 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=300&h=400&fit=crop',
        'profileImageUrl': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=64&h=64&fit=crop&crop=face',
        'hasNewStory': true,
        'storyType': 'travel',
      },
      {
        'id': '6',
        'username': 'fitness_coach',
        'imageUrl': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=400&fit=crop',
        'profileImageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=64&h=64&fit=crop&crop=face',
        'hasNewStory': false,
        'storyType': 'fitness',
      },
    ];
  }

  Color _getStoryTypeColor(String storyType) {
    switch (storyType.toLowerCase()) {
      case 'food':
        return const Color(0xFFFF6B35);
      case 'beauty':
        return const Color(0xFFE91E63);
      case 'fashion':
        return const Color(0xFF9C27B0);
      case 'travel':
        return const Color(0xFF2196F3);
      case 'fitness':
        return const Color(0xFF4CAF50);
      case 'tech':
        return const Color(0xFF607D8B);
      default:
        return const Color(0xFF757575);
    }
  }

  String _getStoryTypeText(String storyType) {
    switch (storyType.toLowerCase()) {
      case 'food':
        return '🍕';
      case 'beauty':
        return '💄';
      case 'fashion':
        return '👗';
      case 'travel':
        return '✈️';
      case 'fitness':
        return '💪';
      case 'tech':
        return '💻';
      default:
        return '📱';
    }
  }

  void _handleStoryTap(BuildContext context, Map<String, dynamic> story) {
    // Handle story tap - could navigate to story viewer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opened story from ${story['username']}'),
        backgroundColor: const Color(0xFF00BCD4),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}