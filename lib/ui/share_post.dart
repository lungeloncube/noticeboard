import 'dart:io';

import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_bloc.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_event.dart';
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
  // bool isGallery = false;
  bool isGalleryImage = false;
  bool isGalleryVideo = false;
  bool isVideo = false;
  String branchId = 'BR-1001';
  File _imageCamera;
  File _imageGallery;
  File _galleryVideo;
  File _video;

  SharePostBloc sharePostBloc;

  @override
  void initState() {
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
                print(getMediaType(
                  isCamera,
                  isGalleryImage,
                  isGalleryVideo,
                  isVideo,
                ));
                sharePostBloc.add(
                  ShareEvent(
                      filename: (isCamera
                          ? _imageCamera
                          : isVideo
                          ? _video
                          : isGalleryImage
                          ? _imageGallery
                          : isGalleryVideo
                          ? _galleryVideo
                          : _imageCamera)==null?'':(isCamera
                              ? _imageCamera
                              : isVideo
                                  ? _video
                                  : isGalleryImage
                                      ? _imageGallery
                                      : isGalleryVideo
                                          ? _galleryVideo
                                          : _imageCamera)
                          .path,
                      branchId: branchId,
                      postText: postTextController.text,
                      categoryId: 1.toString(),
                      userId: '8638313813577931224',
                      file: isCamera
                          ? _imageCamera
                          : isVideo
                              ? _video
                              : isGalleryImage
                                  ? _imageGallery
                                  : isGalleryVideo
                                      ? _galleryVideo
                                      : _imageCamera,
                      mediaType: getMediaType(
                        isCamera,
                        isGalleryImage,
                        isGalleryVideo,
                        isVideo,
                      )),
                );
                postTextController.clear();
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
                    child: Avatar(radius: 20.0, path: 'assets/avatar.png'),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text('FirstUserName User1UATCLGX',
                      style: TextStyle(fontFamily: 'Trebuchet', fontSize: 18)),
                ],
              ),
            ]),
            BlocListener<SharePostBloc, SharePostState>(
              listener: (context, state) {
                if (state is SharePostLoadedState) {
                  BlocProvider.of<AllPostsBloc>(context).add(FetchAllPostsEvents());
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
              onTap: _showMyDialog,
              //   onTap: getGalleryMedia,
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
              uploadedMedia(isCamera, isVideo, isGalleryImage, isGalleryVideo),
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
      isGalleryImage = false;
      isGalleryVideo = false;
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
      isGalleryImage = true;
      isCamera = false;
      isVideo = false;
      isGalleryVideo = false;
      if (galleryFile != null) {
        _imageGallery = File(galleryFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _getGalleryVideo() async {
    isGalleryVideo = true;
    isCamera = false;
    isGalleryImage = false;
    isVideo = false;

    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _galleryVideo = File(pickedFile.path);
      _videoPlayerController = VideoPlayerController.file(_galleryVideo)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController.play();
        });
    } else {
      print('No video selected');
    }
  }

  Future _captureVideo() async {
    isVideo = true;
    isCamera = false;
    isGalleryImage = false;
    isGalleryVideo = false;

    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      _video = File(pickedFile.path);
      _videoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController.play();
        });
    } else {
      print("No video selected");
    }
  }

  Widget uploadedMedia(isCamera, isVideo, isGalleryImage, isGalleryVideo) {
    if (isCamera) {
      if (_imageCamera != null)
        return (Image.file(_imageCamera));
      else {
        return Container();
      }
    }
    if (isVideo) {
      return _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : Container();
    }
    if (isGalleryImage) {
      if (_imageGallery != null)
        return (Image.file(_imageGallery));
      else {
        return Container();
      }
    }
    if (isGalleryVideo) {
      return _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : Container();
    }
    return Container();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              children: [
                OutlinedButton(
                    onPressed: _getGalleryVideo, child: Text("Video")),
                OutlinedButton(onPressed: getGalleryMedia, child: Text("Image"))
              ],
            ),
          ),
        );
      },
    );
  }

  String getMediaType(isCamera, isGalleryImage, isGalleryVideo, isVideo) {
    if (isCamera) {
      return "Image";
    } else if (isGalleryImage) {
      return "Image";
    } else if (isGalleryVideo) {
      return "Video";
    } else if (isVideo) {
      return "Video";
    }
  }
}
