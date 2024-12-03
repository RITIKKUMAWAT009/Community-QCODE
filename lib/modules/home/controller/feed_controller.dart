import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/data/models/feed_model.dart';
import 'package:community/data/services/Firebase/firebase_service.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:video_player/video_player.dart';

class FeedController extends GetxController {
  var feedItems = <Post>[].obs;
  FirebaseService firebaseService = FirebaseService();
 late VideoPlayerController controller;

  // Fetch data from Firestore
  void fetchFeed() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').get();
    feedItems.assignAll(snapshot.docs.map((doc) => Post.fromDocument(doc)).toList());
  }

onInit() {
  feedItems.clear();
  super.onInit();

  fetchFeed();
}

Future<File?> pickMedia({required bool isImage}) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = isImage
      ? await picker.pickImage(source: ImageSource.gallery)
      : await picker.pickVideo(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<void> uploadMediaAndPost({required String profileImage,required String userID ,required String text, required String username,required bool isImage,required File mediaFile}) async {
  try {
    String mediaUrl = isImage
        ? await firebaseService.uploadImage(mediaFile)
        : await firebaseService.uploadVideo(mediaFile);


final newPost = {
  'userId': userID,
  'userName':username,
  'userAvatar': profileImage,
  'contentText': text,
  'contentMedia': mediaUrl,
  'mediaType':isImage? 'image':"video",
  'likes': 0,
  'comments': 0,
  'timestamp': Timestamp.now(),
};
await FirebaseFirestore.instance.collection('posts').add(newPost);
  } catch (e) {
    print('Error uploading media: $e');
  }
}}
