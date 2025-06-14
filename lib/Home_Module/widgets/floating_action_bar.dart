// floating_action_bar.dart
import 'package:bluecs_assignment/common_widgets/assetSvgIcon.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';

class FloatingActionBar extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const FloatingActionBar({
    Key? key,
    required this.post,
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

  // Helper method to get responsive icon size for AssetSvgIcon
  Widget _getResponsiveAssetSvgIcon(BuildContext context, String iconName) {
    final iconSize = _getResponsiveSize(context, 16); // Base icon size
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: AssetSvgIcon(iconName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive dimensions
    final containerHeight = _getResponsiveSize(context, 48);
    final borderRadius = _getResponsiveSize(context, 24);
    final blurRadius = _getResponsiveSize(context, 12);
    final dividerHeight = _getResponsiveSize(context, 16);
    
    // Adjust spacing based on screen width
    final isSmallScreen = screenWidth < 360;
    final baseSpacing = isSmallScreen ? 6.0 : 10.0;
    final smallSpacing = isSmallScreen ? 2.0 : 3.0;
    final mediumSpacing = isSmallScreen ? 4.0 : 6.0;
    
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF161F28).withOpacity(0.8),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withOpacity(0.12),
          width: _getResponsiveSize(context, 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: blurRadius,
            offset: Offset(0, _getResponsiveSize(context, 4)),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: _getResponsiveSize(context, baseSpacing)),
          
          // Overlapping Avatars Section
          _buildOverlappingAvatars(context),
          SizedBox(width: _getResponsiveSize(context, smallSpacing + 1)),
          
          // Comments count and icon
          Text(
            _formatNumber(post.comments),
            style: TextStyle(
              color: Colors.white,
              fontSize: _getResponsiveFontSize(context, 10),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: _getResponsiveSize(context, smallSpacing)),
          GestureDetector(
            onTap: onComment,
            child: _getResponsiveAssetSvgIcon(context, 'comment'),
          ),
          
          // Divider
          Container(
            height: dividerHeight,
            width: _getResponsiveSize(context, 1),
            color: Colors.grey[600],
            margin: EdgeInsets.symmetric(
              horizontal: _getResponsiveSize(context, mediumSpacing),
            ),
          ),
          
          // Reaction Icons with count
          _buildReactionSection(context),
          
          // Spacing
          SizedBox(width: _getResponsiveSize(context, mediumSpacing)),
          
          // Like button
          GestureDetector(
            onTap: onLike,
            child: _getResponsiveAssetSvgIcon(context, 'like'),
          ),
          
          // Another Divider
          Container(
            height: dividerHeight,
            width: _getResponsiveSize(context, 1),
            color: Colors.grey[600],
            margin: EdgeInsets.symmetric(
              horizontal: _getResponsiveSize(context, mediumSpacing),
            ),
          ),
          
          // Share section
          Text(
            _formatNumber(post.shares),
            style: TextStyle(
              color: Colors.white,
              fontSize: _getResponsiveFontSize(context, 10),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: _getResponsiveSize(context, smallSpacing)),
          GestureDetector(
            onTap: onShare,
            child: _getResponsiveAssetSvgIcon(context, 'share'),
          ),
          
          SizedBox(width: _getResponsiveSize(context, 7)),
        ],
      ),
    );
  }

  Widget _buildOverlappingAvatars(BuildContext context) {
    // Sample avatar URLs for demonstration
    final List<String> avatarUrls = [
      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=32&h=32&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1494790108755-2616b332c5ac?w=32&h=32&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=32&h=32&fit=crop&crop=face',
    ];

    final avatarSize = _getResponsiveSize(context, 20);
    final overlapOffset = _getResponsiveSize(context, 8);
    final borderWidth = _getResponsiveSize(context, 1.5);
    final totalWidth = _getResponsiveSize(context, 38);

    return SizedBox(
      width: totalWidth,
      height: avatarSize,
      child: Stack(
        children: List.generate(
          avatarUrls.take(3).length,
          (index) => Positioned(
            left: index * overlapOffset,
            child: Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF161F28),
                  width: borderWidth,
                ),
              ),
              child: CircleAvatar(
                radius: avatarSize / 2 - borderWidth,
                backgroundImage: NetworkImage(avatarUrls[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReactionSection(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Reaction icons
        _getResponsiveAssetSvgIcon(context, 'group_action'),
        SizedBox(width: _getResponsiveSize(context, 4)),
        
        // Reaction count
        Text(
          '5k+',
          style: TextStyle(
            color: Colors.white,
            fontSize: _getResponsiveFontSize(context, 10),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}