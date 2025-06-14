// post_provider.dart
import 'package:flutter/material.dart';

import '../models/post.dart';

class PostProvider extends ChangeNotifier {
final  List<PostModel> _posts = [
    PostModel(
      id: '1',
      title: 'Top 10 AI Tools You Should Know in 2025',
      subtitle: 'Stay Ahead with These Game-Changing AI Tools',
      imageUrl: 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=500&h=300&fit=crop',
      authorName: 'TechSavvy',
      authorImageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=40&h=40&fit=crop&crop=face',
      timeAgo: '5 days ago',
      views: 25000,
      likes: 5400,
      comments: 310,
      shares: 50,
      isVerified: true,
    ),
    PostModel(
      id: '2',
      title: 'Future of Machine Learning in Healthcare',
      subtitle: 'Revolutionary Changes Coming to Medical Industry',
      imageUrl: 'https://www.seldon.io/wp-content/uploads/2025/02/canva2-3.png',
      authorName: 'HealthTech',
      authorImageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=40&h=40&fit=crop&crop=face',
      timeAgo: '2 days ago',
      views: 18500,
      likes: 3200,
      comments: 180,
      shares: 35,
      isVerified: false,
    ),
    PostModel(
      id: '3',
      title: 'Best Coding Practices for Flutter Developers',
      subtitle: 'Write Clean and Maintainable Code',
      imageUrl: 'https://www.quytech.com/blog/wp-content/uploads/2022/05/how-to-hire-flutter-app-developers.png',
      authorName: 'FlutterDev',
      authorImageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=40&h=40&fit=crop&crop=face',
      timeAgo: '1 week ago',
      views: 32000,
      likes: 7800,
      comments: 450,
      shares: 120,
      isVerified: true,
    ),
  ];

  List<PostModel> get posts => _posts;

  void addPost(PostModel post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  void toggleLike(String postId) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      // In a real app, you'd update the like status and count
      notifyListeners();
    }
  }
}
