// post_model.dart
class PostModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String authorName;
  final String authorImageUrl;
  final String timeAgo;
  final int views;
  final int likes;
  final int comments;
  final int shares;
  final bool isVerified;

  PostModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.authorName,
    required this.authorImageUrl,
    required this.timeAgo,
    required this.views,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isVerified = false,
  });
}