import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String userId;
  final String userName;
  final String userAvatar;
  final String contentText;
  final String contentMedia;
  final String mediaType; // "image" or "video"
  final int likes;
  final int comments;
  final DateTime timestamp;

  Post({
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.contentText,
    required this.contentMedia,
    required this.mediaType,
    required this.likes,
    required this.comments,
    required this.timestamp,
  });

  // Factory method to create a Post object from Firebase snapshot
  factory Post.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      postId: doc.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userAvatar: data['userAvatar'] ?? '',
      contentText: data['contentText'] ?? '',
      contentMedia: data['contentMedia'] ?? '',
      mediaType: data['mediaType'] ?? '',
      likes: data['likes'] ?? 0,
      comments: data['comments'] ?? 0,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Convert Post object to a map to save to Firebase
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'contentText': contentText,
      'contentMedia': contentMedia,
      'mediaType': mediaType,
      'likes': likes,
      'comments': comments,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
