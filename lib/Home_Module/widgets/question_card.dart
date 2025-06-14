// question_card.dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'floating_action_bar.dart';

class QuestionCard extends StatelessWidget {
  final PostModel post;
  final List<String> options;
  final int? selectedOption;
  final ValueChanged<int>? onOptionSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const QuestionCard({
    Key? key,
    required this.post,
    required this.options,
    this.selectedOption,
    this.onOptionSelected,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Card
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1C252D),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with time and views
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Time ago
                      Text(
                        post.timeAgo,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Views with icon
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.grey[500],
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatNumber(post.views),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Question Title
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: Text(
                    post.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
                
                // Options Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    children: List.generate(
                      options.length,
                      (index) => _buildOptionButton(
                        label: String.fromCharCode(65 + index), // A, B, C, D
                        text: options[index],
                        isSelected: selectedOption == index,
                        onTap: () => onOptionSelected?.call(index),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Author Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      // Author Avatar
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF6C63FF),
                            width: 1.5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(post.authorImageUrl),
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      // Author Name
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              post.authorName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (post.isVerified) ...[
                              const SizedBox(width: 3),
                              Container(
                                padding: const EdgeInsets.all(1.5),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF6C63FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 8,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      // Content Creator Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[800]?.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Content Creator',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      
                      // Close button (X)
                      const SizedBox(width: 8),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
          
          // Floating Action Container
          Positioned(
            bottom: -24,
            left: 16,
            right: 16,
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

  Widget _buildOptionButton({
    required String label,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00A8FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF00A8FF) : Colors.grey[600]!,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Option Label (A, B, C, D)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                  border: isSelected ? null : Border.all(
                    color: Colors.grey[600]!,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$label.',
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF00A8FF) : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Option Text
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[300],
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}