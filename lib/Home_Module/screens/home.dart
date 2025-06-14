import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../widgets/home_appbar.dart';
import '../widgets/post_card.dart';
import '../widgets/question_card.dart';
import '../widgets/story_section.dart';
import '../widgets/tab_widget.dart';
import '../providers/post_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Track selected options for question cards
  Map<String, int> selectedOptions = {};

  // Sample question data - you can move this to your PostProvider or create a QuestionProvider
  final List<Map<String, dynamic>> questionData = [
    {
      'id': 'q1',
      'question': 'What is the most important factor when choosing a new job?',
      'options': [
        'Salary & Benefits',
        'Work-Life Balance',
        'Career Growth Opportunities',
        'Company Culture'
      ],
      'timeAgo': '5 days ago',
      'views': 25000,
      'authorName': 'TechSavvy',
      'authorImageUrl': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=32&h=32&fit=crop&crop=face',
      'isVerified': true,
      'comments': 310,
      'likes': 5000,
      'shares': 50,
    },
    {
      'id': 'q2',
      'question': 'Which programming language should beginners learn first?',
      'options': [
        'Python',
        'JavaScript',
        'Java',
        'C++'
      ],
      'timeAgo': '2 days ago',
      'views': 18500,
      'authorName': 'CodeMaster',
      'authorImageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=32&h=32&fit=crop&crop=face',
      'isVerified': false,
      'comments': 245,
      'likes': 3200,
      'shares': 28,
    },
  ];

  // Helper method to get responsive dimensions
  double _getResponsiveSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    
    // Base width assumption (iPhone 12/13 Pro width: 390)
    const baseWidth = 390.0;
    final scaleFactor = (screenWidth / baseWidth) * (pixelRatio / 3.0);
    
    return baseSize * scaleFactor.clamp(0.8, 1.4);
  }

  double _getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    
    // Base width assumption
    const baseWidth = 390.0;
    final scaleFactor = (screenWidth / baseWidth).clamp(0.85, 1.2);
    
    return (baseFontSize * scaleFactor) / textScaleFactor;
  }

  EdgeInsets _getResponsivePadding(BuildContext context, EdgeInsets basePadding) {
    return EdgeInsets.only(
      left: _getResponsiveSize(context, basePadding.left),
      top: _getResponsiveSize(context, basePadding.top),
      right: _getResponsiveSize(context, basePadding.right),
      bottom: _getResponsiveSize(context, basePadding.bottom),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Responsive dimensions
    final drawerIconSize = _getResponsiveSize(context, 24);
    final drawerFontSize = _getResponsiveFontSize(context, 16);
    final drawerHeaderFontSize = _getResponsiveFontSize(context, 24);
    final topSectionPadding = _getResponsivePadding(context, const EdgeInsets.all(16.0));
    final bottomPadding = _getResponsiveSize(context, 66);
    final itemSpacing = _getResponsiveSize(context, 16);
    final endSpacing = _getResponsiveSize(context, 50);
    
    // Adjust drawer width based on screen size
    final drawerWidth = screenWidth * 0.75; // 75% of screen width
    final maxDrawerWidth = _getResponsiveSize(context, 280);
    final minDrawerWidth = _getResponsiveSize(context, 240);
    final finalDrawerWidth = drawerWidth.clamp(minDrawerWidth, maxDrawerWidth);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const HomeAppBar(),
      drawer: SizedBox(
        width: finalDrawerWidth,
        child: Drawer(
          backgroundColor: const Color(0xFF1A1A1A),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF00BCD4),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: drawerHeaderFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.home,
                title: 'Home',
                iconSize: drawerIconSize,
                fontSize: drawerFontSize,
                onTap: () => Navigator.pop(context),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.person,
                title: 'Profile',
                iconSize: drawerIconSize,
                fontSize: drawerFontSize,
                onTap: () => Navigator.pop(context),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.settings,
                title: 'Settings',
                iconSize: drawerIconSize,
                fontSize: drawerFontSize,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section with tabs
          Padding(
            padding: topSectionPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: _getResponsiveSize(context, 16)),
                const ResponsiveTabsWidget(),
                SizedBox(height: _getResponsiveSize(context, 16)),
              ],
            ),
          ),
          
          // Mixed Feed (Social Posts + Question Cards + Stories)
          Expanded(
            child: Consumer<PostProvider>(
              builder: (context, postProvider, child) {
                final totalPosts = postProvider.posts.length;
                final totalQuestions = questionData.length;
                final totalItems = totalPosts + totalQuestions + 1; // +1 for stories section

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  itemCount: totalItems,
                  itemBuilder: (context, index) {
                    final totalContentItems = totalPosts + totalQuestions;
                    
                    // Show stories section at the end
                    if (index == totalContentItems) {
                      return Column(
                        children: [
                          SizedBox(height: itemSpacing),
                          const StoriesSection(),
                          SizedBox(height: endSpacing),
                        ],
                      );
                    }
                    
                    // Alternate between social posts and question cards
                    if (index % 2 == 0) {
                      // Show social post
                      final postIndex = index ~/ 2;
                      if (postIndex < postProvider.posts.length) {
                        final post = postProvider.posts[postIndex];
                        return Column(
                          children: [
                            if (index > 0) SizedBox(height: itemSpacing),
                            SocialPostCard(
                              post: post,
                              onTap: () {
                                _handlePostTap(post);
                              },
                              onLike: () {
                                _handleLike(post);
                              },
                              onComment: () {
                                _handleComment(post);
                              },
                              onShare: () {
                                _handleShare(post);
                              },
                            ),
                          ],
                        );
                      }
                    } else {
                      // Show question card
                      final questionIndex = (index - 1) ~/ 2;
                      if (questionIndex < questionData.length) {
                        final questionItem = questionData[questionIndex];
                        
                        // Create a PostModel for the question card
                        final questionPost = PostModel(
                          id: questionItem['id'],
                          title: questionItem['question'],
                          subtitle: '',
                          imageUrl: '', // No image for question cards
                          authorName: questionItem['authorName'],
                          authorImageUrl: questionItem['authorImageUrl'],
                          timeAgo: questionItem['timeAgo'],
                          views: questionItem['views'],
                          likes: questionItem['likes'],
                          comments: questionItem['comments'],
                          shares: questionItem['shares'],
                          isVerified: questionItem['isVerified'],
                        );
                        
                        return Column(
                          children: [
                            SizedBox(height: itemSpacing),
                            QuestionCard(
                              post: questionPost,
                              options: List<String>.from(questionItem['options']),
                              selectedOption: selectedOptions[questionItem['id']],
                              onOptionSelected: (optionIndex) {
                                _handleOptionSelected(questionItem['id'], optionIndex);
                              },
                              onLike: () {
                                _handleQuestionLike(questionPost);
                              },
                              onComment: () {
                                _handleComment(questionPost);
                              },
                              onShare: () {
                                _handleShare(questionPost);
                              },
                            ),
                          ],
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required double iconSize,
    required double fontSize,
    required VoidCallback onTap,
  }) {
    final itemPadding = _getResponsivePadding(
      context, 
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
    
    return ListTile(
      contentPadding: itemPadding,
      leading: Icon(
        icon,
        color: const Color(0xFF00BCD4),
        size: iconSize,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      visualDensity: VisualDensity.comfortable,
    );
  }

  void _handleOptionSelected(String questionId, int optionIndex) {
    setState(() {
      selectedOptions[questionId] = optionIndex;
    });
    
    // Show feedback for selected option
    final optionLabels = ['A', 'B', 'C', 'D'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected option ${optionLabels[optionIndex]}',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 14),
          ),
        ),
        backgroundColor: const Color(0xFF00A8FF),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: _getResponsivePadding(
          context,
          const EdgeInsets.all(16),
        ),
      ),
    );
  }

  void _handlePostTap(PostModel post) {
    // Handle post tap - maybe navigate to detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opened: ${post.title}',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 14),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFF00BCD4),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: _getResponsivePadding(
          context,
          const EdgeInsets.all(16),
        ),
      ),
    );
  }

  void _handleLike(PostModel post) {
    // Handle like action for social posts
    Provider.of<PostProvider>(context, listen: false).toggleLike(post.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Liked: ${post.title}',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 14),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFF4285F4),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: _getResponsivePadding(
          context,
          const EdgeInsets.all(16),
        ),
      ),
    );
  }

  void _handleQuestionLike(PostModel post) {
    // Handle like action for question cards
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Liked question: ${post.title}',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 14),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFF4285F4),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: _getResponsivePadding(
          context,
          const EdgeInsets.all(16),
        ),
      ),
    );
  }

  void _handleComment(PostModel post) {
    // Handle comment action - maybe show comment dialog
    _showCommentDialog(post);
  }

  void _handleShare(PostModel post) {
    // Handle share action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Shared: ${post.title}',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 14),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFF00BCD4),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: _getResponsivePadding(
          context,
          const EdgeInsets.all(16),
        ),
      ),
    );
  }

  void _showCommentDialog(PostModel post) {
    final dialogTitleFontSize = _getResponsiveFontSize(context, 18);
    final dialogContentFontSize = _getResponsiveFontSize(context, 14);
    final dialogSubtitleFontSize = _getResponsiveFontSize(context, 12);
    final dialogPadding = _getResponsivePadding(context, const EdgeInsets.all(24));
    final buttonFontSize = _getResponsiveFontSize(context, 14);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          contentPadding: dialogPadding,
          title: Text(
            'Comments',
            style: TextStyle(
              color: Colors.white,
              fontSize: dialogTitleFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: dialogSubtitleFontSize,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: _getResponsiveSize(context, 16)),
              Text(
                'Comments feature coming soon!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: dialogContentFontSize,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(
                  color: const Color(0xFF00BCD4),
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}