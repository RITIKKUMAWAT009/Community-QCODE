import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseService {
  // FirebaseStorage instance
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // Function to upload an image to Firebase Storage
   Future<String> uploadImage(File imageFile) async {
    try {
      // Create a unique file name for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString(); 
      Reference imageRef = _storage.ref().child('images/$fileName.jpg');

      // Upload the image to Firebase Storage
      UploadTask uploadTask = imageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      
      // Get the download URL for the uploaded image
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  // Function to upload a video to Firebase Storage
   Future<String> uploadVideo(File videoFile) async {
    try {
      // Create a unique file name for the video
      String fileName = DateTime.now().millisecondsSinceEpoch.toString(); 
      Reference videoRef = _storage.ref().child('videos/$fileName.mp4');

      // Upload the video to Firebase Storage
      UploadTask uploadTask = videoRef.putFile(videoFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      
      // Get the download URL for the uploaded video
      String videoUrl = await snapshot.ref.getDownloadURL();
      return videoUrl;
    } catch (e) {
      print('Error uploading video: $e');
      return '';
    }
  }

  // Function to pick an image using image_picker
   Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Function to pick a video using image_picker
   Future<File?> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
