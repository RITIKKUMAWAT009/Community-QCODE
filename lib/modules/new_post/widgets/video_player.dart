import 'dart:io';

import 'package:community/core/utils/theme/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
 
 VideoPlayerWidget({ required this.media, required this.isNetworkFile, required this.controller});
  final VideoPlayerController controller;

   final String media;

  final bool isNetworkFile;

  // @override
  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller,),
          )
        : Center(child: CircularProgressIndicator());
  }
}
