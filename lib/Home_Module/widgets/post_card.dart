// social_post_card.dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'floating_action_bar.dart';

class SocialPostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const SocialPostCard({
    Key? key,
    required this.post,
    this.onTap,
    this.onLike,
    this.onComment,
    this.onShare,
  }) : super(key: key);

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    
    // Responsive dimensions
    final horizontalMargin = _getResponsiveSize(context, 16);
    final verticalMargin = _getResponsiveSize(context, 12);
    final borderRadius = _getResponsiveSize(context, 16);
    final imageHeight = screenHeight * 0.25; // 25% of screen height
    final contentPadding = _getResponsiveSize(context, 16);
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Card
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1C252D),
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: _getResponsiveSize(context, 8),
                  offset: Offset(0, _getResponsiveSize(context, 4)),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Image with overlay
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: imageHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(borderRadius),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(post.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(borderRadius),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Views indicator
                          Positioned(
                            top: _getResponsiveSize(context, 12),
                            left: _getResponsiveSize(context, 12),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: _getResponsiveSize(context, 6),
                                vertical: _getResponsiveSize(context, 3),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(
                                  _getResponsiveSize(context, 10),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                    size: _getResponsiveSize(context, 10),
                                  ),
                                  SizedBox(width: _getResponsiveSize(context, 3)),
                                  Text(
                                    _formatNumber(post.views),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: _getResponsiveFontSize(context, 10),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Time ago
                          Positioned(
                            bottom: _getResponsiveSize(context, 12),
                            right: _getResponsiveSize(context, 12),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: _getResponsiveSize(context, 8),
                                vertical: _getResponsiveSize(context, 4),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(
                                  _getResponsiveSize(context, 12),
                                ),
                              ),
                              child: Text(
                                post.timeAgo,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _getResponsiveFontSize(context, 11),
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
                
                // Content Section
                Padding(
                  padding: EdgeInsets.all(contentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        post.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _getResponsiveFontSize(context, 18),
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: _getResponsiveSize(context, 4)),
                      
                      // Subtitle
                      Text(
                        post.subtitle,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: _getResponsiveFontSize(context, 12),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: _getResponsiveSize(context, 16)),
                      
                      // Author Section
                      Row(
                        children: [
                          // Author Avatar
                          Container(
                            width: _getResponsiveSize(context, 28),
                            height: _getResponsiveSize(context, 28),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF6C63FF),
                                width: _getResponsiveSize(context, 1.5),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: _getResponsiveSize(context, 12),
                              backgroundImage: NetworkImage(post.authorImageUrl),
                            ),
                          ),
                          SizedBox(width: _getResponsiveSize(context, 8)),
                          
                          // Author Name
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  post.authorName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _getResponsiveFontSize(context, 12),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (post.isVerified) ...[
                                  SizedBox(width: _getResponsiveSize(context, 3)),
                                  Container(
                                    padding: EdgeInsets.all(
                                      _getResponsiveSize(context, 1.5),
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6C63FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: _getResponsiveSize(context, 8),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          
                          // Content Creator Badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: _getResponsiveSize(context, 5),
                              vertical: _getResponsiveSize(context, 2),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[800]?.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(
                                _getResponsiveSize(context, 6),
                              ),
                            ),
                            child: Text(
                              'Content Creator',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: _getResponsiveFontSize(context, 9),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: _getResponsiveSize(context, 24)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Floating Action Container
          Positioned(
            bottom: -_getResponsiveSize(context, 24),
            left: _getResponsiveSize(context, 16),
            right: _getResponsiveSize(context, 16),
            child: FloatingActionBar(
              post: post,
              onLike: onLike,
              onComment: onComment,
              onShare: onShare,
            ),
          ),
        ],
      ),
    );
  }
}