import 'dart:io';

import 'package:digital_notice_board/widgets/Icon.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer' as dev;

class SharePost extends StatefulWidget {
  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  static const String LOG_NAME = 'screen.landing';
  TextEditingController messageController = TextEditingController();
  bool isCamera = false;
  bool isGallery = false;
  bool isVideo = false;
 File _image;
  File _video;


  @override
  Widget build(BuildContext context) {
    dev.log('In share post page', name: LOG_NAME);
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Post',
            style: TextStyle(fontFamily: 'Trebuchet', fontSize: 22)),
        actions: [
          TextButton(
              onPressed: () {},
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
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: BorderlessInputField(
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
  final picker = ImagePicker();
  VideoPlayerController _videoPlayerController;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      isCamera = true;
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getGalleryMedia() async {
    final galleryFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      isGallery = true;
      if (galleryFile != null) {
        _image = File(galleryFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _captureVideo() async {
    isVideo = true;
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
      return (Image.file(_image));
    }
    if (isVideo) {
      return _videoPlayerController.value.initialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : Container();
    } else if (isGallery) {
      return (Image.file(_image));
    }

    return Container();
  }
}
