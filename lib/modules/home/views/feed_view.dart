import 'package:cached_network_image/cached_network_image.dart';
import 'package:community/data/models/feed_model.dart';
import 'package:community/modules/home/controller/feed_controller.dart';
import 'package:community/modules/home/views/image_video_play_page.dart';
import 'package:community/modules/home/views/post_feed.dart';
import 'package:community/modules/home/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
class FeedPage extends StatelessWidget {
  final FeedController feedController = Get.put(FeedController());
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed')),
      body: Obx(() {
        return ListView.builder(
          itemCount: feedController.feedItems.length,
          itemBuilder: (context, index) {
            var item = feedController.feedItems[index];
            return Container(
              height: 700,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username and Timestamp
                    Row(
                      children: [
                        CircleAvatar(child: Text(item.userName)),
                       const SizedBox(width: 10),
                        Text(
                          item.userName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(item.timestamp.toString()),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(item.contentText),
                    SizedBox(height: 10),
                    // Image (optional)
                    if (item.mediaType=='video' && item.contentMedia.isNotEmpty)
                      // Image.network(item.contentMedia),
                      VideoPlayerWidget( controller:VideoPlayerController.network(item.contentMedia),media: item.contentMedia,isNetworkFile: true,),
              
                    // Video (if exists)
                    if (item.mediaType=="image" && item.contentMedia.isNotEmpty)
                     CachedNetworkImage(height: 500,width:double.infinity,fit: BoxFit.fitWidth,imageUrl: item.contentMedia),
              
                      // VideoPlayerWidget(videoUrl: item.videoUrl!),
                    SizedBox(height: 10),
                    // Comment & Share Buttons
                    Row(
                      children: [
                        IconButton(
                          icon:const Icon(Icons.comment),
                          onPressed: () {
                            print('Comment clicked');
                          },
                        ),
                        IconButton(
                          icon:const Icon(Icons.share),
                          onPressed: () {
                            print('Share clicked');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton:FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title:const Text('Take Photo'),
                    onTap: () {
                      _takePhoto();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title:const Text('Record Video'),
                    onTap: () {
                      _recordVideo();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title:const Text('Pick Image from Gallery'),
                    onTap: () {
                      _pickImageFromGallery();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title:const Text('Pick Video from Gallery'),
                    onTap: () {
                      _pickVideoFromGallery();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );},
       
       ); },
      ),
    );
  }
   Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      // Handle the photo (e.g., upload to Firebase, show preview, etc.)
      Get.to(ImageVideoPlayPage(isNetworkFile: false,mediaFile: photo,));
      print('Photo taken: ${photo.path}');
    }
  }

  // Method to open camera for recording a video
  Future<void> _recordVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      // Handle the video (e.g., upload to Firebase, show preview, etc.)
      Get.to(()=>ImageVideoPlayPage(isNetworkFile: false,mediaFile: video,));
      print('Video recorded: ${video.path}');
    }
  }

  // Method to open gallery for picking an image
  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Get.to(ImageVideoPlayPage(isNetworkFile: false,mediaFile: image,));
      // Handle the selected image...
      
      print('Picked Image: ${image.path}');
    }
  }

  // Method to open gallery for picking a video
  Future<void> _pickVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      // Handle the selected video
      Get.to(()=>ImageVideoPlayPage(isNetworkFile: false, mediaFile: video,));

      print('Picked Video: ${video.path}');
    }
  }

}
// class FeedItem extends StatelessWidget {
//   final Post post;

//   FeedItem({required this.post});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       margin: EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // User Info
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(post.userAvatar),
//                 ),
//                 SizedBox(width: 10),
//                 Text(post.userName, style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//             SizedBox(height: 10),
//             // Post Content
//             Text(post.timestamp.toLocal().toString()),
//             SizedBox(height: 10),
//             // Media Content
//             if (post.mediaType == "image")
//               CachedNetworkImage(imageUrl: post.contentMedia)
//             else if (post == "video")
//               VideoPlayerWidget(isNetworkFile: true,media: post.contentMedia),
//             // Like, Comment, Share Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up), tooltip: 'Like'),
//                 IconButton(onPressed: () {}, icon: Icon(Icons.comment), tooltip: 'Comment'),
//                 IconButton(onPressed: () {}, icon: Icon(Icons.share), tooltip: 'Share'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
