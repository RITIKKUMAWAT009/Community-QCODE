import 'dart:io';

import 'package:community/core/bindings/navigation_menu.dart';
import 'package:community/core/utils/constants/sizes.dart';
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:community/modules/home/controller/feed_controller.dart';
import 'package:community/modules/home/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class PostFeedPage extends StatefulWidget {
  final XFile mediaFile;

  const PostFeedPage({Key? key, required this.mediaFile}) : super(key: key);

  @override
  _PostFeedPageState createState() => _PostFeedPageState();
}

class _PostFeedPageState extends State<PostFeedPage> {
  final _controller = TextEditingController();
  final FeedController feedController = Get.put(FeedController());
  XFile? _mediaFile; // For storing selected image/video
late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mediaFile = widget.mediaFile;
    controller=VideoPlayerController.file(File(widget.mediaFile.path)) ..initialize().then((_) {
        setState(() {
          controller.play();
          controller.setLooping(true);
        });});
  }

  // Submit Post
  void _submitPost() {
    String postText = _controller.text;
    // Handle the post submission here (Upload to Firebase, etc.)
    print('Post Text: $postText');
    if (_mediaFile != null) {
      feedController.uploadMediaAndPost(
          isImage: !_mediaFile!.path.endsWith(".mp4"),
          mediaFile: File(_mediaFile!.path),
          text: '',
          profileImage: '',
          userID: '',
          username: '');
      print('Media Path: ${_mediaFile?.path}');
    }
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    _controller.dispose();
    feedController.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode=HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_new,color:isDarkMode?Colors.white:Colors.black,),onPressed: (){
                Get.offAll(() => const NavigationExample(),transition: Transition.zoom,duration: const Duration(milliseconds: 600));

        },),
        title: const Text('Create Post')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if (_mediaFile != null) ...[
                const SizedBox(height: 16),
                _mediaFile?.path.endsWith('.mp4') == true
                    ? Row(
                      children: [
                        Container(
                            height: 300,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(25)),
                                border: Border.all(width: 2)),
                            width: 100,
                            child: VideoPlayerWidget(controller: controller,
                                isNetworkFile: false, media: _mediaFile!.path)),
                 const SizedBox(width: 10,),
                   Expanded(
                     child: TextFormField(expands: false,
                     textDirection: TextDirection.ltr,
                     maxLines: 11,
                                   keyboardType: TextInputType.text,
                                   decoration: InputDecoration(
                      labelText: "Share your post and Idea",
                      alignLabelWithHint: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      filled: true,
                      fillColor:isDarkMode?Colors.white12 : Colors.grey.shade200,
                      hintStyle: TextStyle(color:isDarkMode?Colors.white: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(new Radius.circular(25.0))),
                      labelStyle: TextStyle(color:isDarkMode?Colors.white: Colors.black),
                      floatingLabelStyle: TextStyle(color:isDarkMode?Colors.white: Colors.black,fontSize: 16),
                      ),
        
                                   textAlign: TextAlign.left,
                                   style: TextStyle(
                                     color:isDarkMode?Colors.white: Colors.black,
                                     fontSize: 16.0,
                                   ),
                                   // controller: host,
                                   validator: (value) {
                                     if (value!.isEmpty) {
                      return "Empty value";
                                     }
                                   },
                                 ),
                   )
                      ],
                    )
                    : Row(
                      children: [
                        Container(
                            height: 300,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(25)),
                                border: Border.all(width: 2,style: BorderStyle.solid,strokeAlign: BorderSide.strokeAlignCenter)),
                            width: 100,
                            child: Image.file(fit:BoxFit.fitHeight,
                                 File(_mediaFile!.path)),),
                 const SizedBox(width: 10,),
                   Expanded(
                     child: TextFormField(expands: false,
                     maxLength:250,
                     textDirection: TextDirection.ltr,buildCounter: (
                BuildContext context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) {
                return Text(
                  "$currentLength / $maxLength",
                  style: TextStyle(
                    fontSize: 12,
                    color: isFocused ? Colors.blue : Colors.grey,
                  ),
                );
              },
                     maxLines: 11,
                                   keyboardType: TextInputType.text,
                                   decoration: InputDecoration(
                      labelText: "Share your post and Idea",
                      filled: true,
                      fillColor:isDarkMode?Colors.white12 : Colors.grey.shade200,
                      hintStyle: TextStyle(color:isDarkMode?Colors.white: Colors.grey),
                      border: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(  Radius.circular(25.0))),
                      labelStyle: TextStyle(color:isDarkMode?Colors.white: Colors.grey)),
                                   textAlign: TextAlign.left,
                                   style: TextStyle(
                                     color:isDarkMode?Colors.white: Colors.black,
                                     fontSize: 16.0,
                                   ),
                                  
                                   validator: (value) {
                                     if (value!.isEmpty) {
                      return "Empty value";
                                     }
                                     return null;
                                   },
                                 ),
                   )
                      ],
                    )
        ,
                    SizedBox(
                      height:170,
                      child: InlineTagInputField())
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 26.0),
        child:  ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: _submitPost,
            child: const Text(
              "Post",
              style:TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}



class InlineTagInputField extends StatefulWidget {
  @override
  _InlineTagInputFieldState createState() => _InlineTagInputFieldState();
}

class _InlineTagInputFieldState extends State<InlineTagInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<String> _tags = [];
final ScrollController scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    final bool isDark=HelperFunctions.isDarkMode(context);
    return  Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          height: 100,
          
          // padding: const EdgeInsets.symmetric(horizontal: 8.0,),
          decoration: BoxDecoration(
            color: isDark?Colors.black12:Colors.grey.shade200,
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Scrolling container for tags
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 70, // Set the maximum height for tags container
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Wrap(
                    spacing: 8.0, // Space between tags horizontally
                    runSpacing: 4.0, // Space between rows of tags
                    children: _tags
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tag,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _tags.remove(tag);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              // Input field for new tags
              TextField(
                
                controller: _controller,
                focusNode: _focusNode,
                decoration:  InputDecoration(
                  filled: true,
                  enabledBorder:InputBorder.none,
                  focusedBorder:InputBorder.none,
                      fillColor:isDark ?Colors.white12 : Colors.grey.shade200,
                  border: InputBorder.none,
                  hintText: "Type a tag/hashtag and press Enter",
                  
                  hintStyle:TextStyle(color:isDark?Colors.white: Colors.grey)
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    setState(() {
                      _tags.add(value.trim());
scrollController.animateTo(scrollController.position.maxScrollExtent, duration:Duration(milliseconds:200), curve:Curves.bounceIn);
                      _controller.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ),
      
    );
  }
}
