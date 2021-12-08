import 'dart:io';

import 'package:digital_notice_board/blocs/share_post/share_post_bloc.dart';
import 'package:digital_notice_board/blocs/share_post/share_post_event.dart';
import 'package:digital_notice_board/blocs/share_post/share_post_state.dart';
import 'package:digital_notice_board/widgets/Icon.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/loading_indicator.dart';
import 'package:digital_notice_board/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer' as dev;

class SharePost extends StatefulWidget {
  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  static const String LOG_NAME = 'screen.SharePost';
  TextEditingController postTextController = TextEditingController();
  bool isCamera = false;
  bool isGallery = false;
  bool isVideo = false;
  String branchId = 'BR-1001';
  File _imageCamera;
  File _imageGallery;
  File _video;

  SharePostBloc sharePostBloc;

  @override
  void initState() {
    // TODO: implement initState

    sharePostBloc = BlocProvider.of<SharePostBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dev.log('In share post page', name: LOG_NAME);
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Post',
            style: TextStyle(fontFamily: 'Trebuchet', fontSize: 22)),
        actions: [
          TextButton(
              onPressed: () {
                print(
                  'path is' +
                      (isCamera
                              ? _imageCamera
                              : isGallery
                                  ? _imageGallery
                                  : isVideo
                                      ? _video
                                      : _imageGallery)
                          .path,
                );
                sharePostBloc.add(ShareEvent(
                    filename: (isCamera
                            ? _imageCamera
                            : isGallery
                                ? _imageGallery
                                : isVideo
                                    ? _video
                                    : _imageGallery)
                        .path,
                    branchId: branchId,
                    postText: postTextController.text,
                    categoryId: 1.toString(),
                    userId: '-5906054645658519212',
                    file: isCamera
                        ? _imageCamera
                        : isGallery
                            ? _imageGallery
                            : isVideo
                                ? _video
                                : _imageGallery));
              },
              child: Text("Post",
                  style: TextStyle(
                      fontFamily: 'Trebuchet',
                      fontSize: 18,
                      color: Colors.white)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey,
                    child: Avatar(radius: 20.0, path: 'assets/three.jpg'),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text('Jennifer Kristy Roberts-RN',
                      style: TextStyle(fontFamily: 'Trebuchet', fontSize: 18)),
                ],
              ),
            ]),
            BlocListener<SharePostBloc, SharePostState>(
              listener: (context, state) {
                if (state is SharePostLoadedState) {
                  if (state.shared)
                    return ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Post created successfully"),
                      ),
                    );
                  else
                    return ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Failed to create post"),
                      ),
                    );
                }
                if (state is SharePostErrorState) {
                  return ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "An error occured while posting, please try again"),
                    ),
                  );
                }
              },
              child: BlocBuilder<SharePostBloc, SharePostState>(
                builder: (context, state) {
                  if (state is SharePostInitial) {
                    return LoadingIndicator();
                  } else if (state is SharePostLoadingState) {
                    return LoadingIndicator();
                  } else if (state is SharePostLoadedState) {
                    return _buildSharePost();
                  }

                  return _buildSharePost();
                },
              ),
            ),
          ]),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.grey[200],
        child: Row(
          children: [
            SizedBox(width: 20),
            GestureDetector(
              onTap: getImage,
              child: ActionIcon(
                icon: Icons.camera_alt,
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: _captureVideo,
              child: ActionIcon(
                icon: Icons.videocam,
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: getGalleryMedia,
              child: ActionIcon(
                icon: Icons.photo,
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/reminder');
              },
              child: ActionIcon(
                icon: Icons.notifications,
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildSharePost() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: BorderlessInputField(
              controller: postTextController,
              hint: 'What would you like to post?',
              maxLines: null,
            )),
        Container(
          child: Column(
            children: <Widget>[
              uploadedMedia(isCamera, isVideo, isGallery),
            ],
          ),
        ),
      ],
    );
  }

  final picker = ImagePicker();
  VideoPlayerController _videoPlayerController;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      isCamera = true;
      isGallery = false;
      isVideo = false;

      if (pickedFile != null) {
        _imageCamera = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getGalleryMedia() async {
    final galleryFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      isGallery = true;
      isCamera = false;
      isVideo = false;
      if (galleryFile != null) {
        _imageGallery = File(galleryFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _captureVideo() async {
    isVideo = true;
    isCamera = false;
    isGallery = false;
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);
    _video = File(pickedFile.path);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  Widget uploadedMedia(isCamera, isVideo, isGallery) {
    if (isCamera) {
      if (_imageCamera != null)
        return (Image.file(_imageCamera));
      else {
        return Container();
      }
    }
    if (isVideo) {
      return _videoPlayerController.value.initialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : Container();
    } else if (isGallery) {
      if (_imageGallery != null)
        return (Image.file(_imageGallery));
      else {
        return Container();
      }
    }

    return Container();
  }
}
