import 'dart:io';

import 'package:digital_notice_board/widgets/Icon.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class SharePost extends StatefulWidget {
  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  TextEditingController messageController = TextEditingController();
  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
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
      if (galleryFile != null) {
        _image = File(galleryFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Post',
            style: TextStyle(fontFamily: 'Trebuchet', fontSize: 20)),
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
                    child: Avatar(radius: 20.0,path:'assets/three.jpg'),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text('Jennifer Kristy Roberts-RN',
                      style: TextStyle(fontFamily: 'Trebuchet', fontSize: 16)),
                ],
              ),
            ]),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputField(
                  hint: 'What would you like to post?',
                  maxLines: null,
                )),
            Container(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
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
              child: Icon(
                Icons.camera_alt,
                size: 35,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 20),
            ActionIcon(icon: Icons.videocam,),
            SizedBox(width: 20),
            GestureDetector(
                onTap: getGalleryMedia,
                child: ActionIcon(icon: Icons.photo,),),
            SizedBox(width: 20),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/reminder');
                },
                child:  ActionIcon(icon: Icons.notifications,),)
          ],
        ),
      ),
    );
  }
}




