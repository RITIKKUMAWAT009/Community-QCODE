import 'dart:io';

import 'package:community/core/utils/theme/logging/logger.dart';
import 'package:community/modules/home/controller/feed_controller.dart';
import 'package:community/modules/home/views/post_feed.dart';
import 'package:community/modules/home/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImageVideoPlayPage extends StatefulWidget {
  const ImageVideoPlayPage(
      {super.key, required this.mediaFile, required this.isNetworkFile});
  final XFile mediaFile;
  final bool isNetworkFile;

  @override
  State<ImageVideoPlayPage> createState() => _ImageVideoPlayPageState();
}

class _ImageVideoPlayPageState extends State<ImageVideoPlayPage> {
  final _controller = TextEditingController();
  final FeedController feedController = Get.put(FeedController());
  XFile? _mediaFile; // For storing selected image/video

  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    RLoggerHelper.debug("init ");


    _mediaFile = widget.mediaFile;
    _videoController = widget.isNetworkFile
        ?( VideoPlayerController.network(widget.mediaFile.path,
            videoPlayerOptions: VideoPlayerOptions(
                mixWithOthers: true,
                allowBackgroundPlayback: true,
                webOptions: VideoPlayerWebOptions(
                    controls: VideoPlayerWebOptionsControls.enabled()))
                    )..initialize().then((_) {
        setState(() {
          _videoController.play();
        });}
                       )   )
        : VideoPlayerController.file(File(widget.mediaFile.path),
            videoPlayerOptions: VideoPlayerOptions(
                mixWithOthers: true,
                allowBackgroundPlayback: true,
                webOptions: VideoPlayerWebOptions(
                    controls: VideoPlayerWebOptionsControls.enabled()))
                    )
      ..initialize().then((_) {
        setState(() {
          _videoController.play();
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    RLoggerHelper.error("diposing");
    _videoController.dispose();
    super.dispose();
  }

// @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//     _mediaFile=widget.mediaFile;
//   }
  // Submit Post

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_mediaFile != null) ...[
              SizedBox(height: 16),
              _mediaFile?.path.endsWith('.mp4') == true
                  ? Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(25)),
                      child: Stack(
                        children: [
                          VideoPlayerWidget(
                              controller: _videoController,
                              isNetworkFile: false,
                              media: _mediaFile!.path),
                          Center(
                            child: IconButton(
                                onPressed: () {
                                  _videoController.play();
                                },
                                icon: Icon(Icons.reset_tv_outlined)),
                          )
                        ],
                      ))
                  : Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(25)),
                      child: Image.file(File(_mediaFile!.path))),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 26.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  _videoController.dispose();
                  Get.to(() => PostFeedPage(mediaFile: _mediaFile!));
                },
                child: Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
