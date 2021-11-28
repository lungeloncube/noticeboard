import 'package:flutter/material.dart';

class SharePost extends StatefulWidget {
  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Share Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row( children: [

              Column(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/three.jpg'),
                    ),
                  ),
                ],
              ),
              SizedBox(width:10),
              Column(
                children: [
                  Text('Jennifer Kristy Roberts-RN'),
                ],
              ),

            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
              decoration: InputDecoration(
              hintText: 'What would you like to post?',),
                controller: messageController,
              ),
            ),
          ]),
        ),
      bottomSheet:Container(
        color:Colors.grey[200],
        child: Row(children: [
          SizedBox(width:20),
            Icon(Icons.camera_alt, size:30,color: Colors.blue,),
          SizedBox(width:20),
          Icon(Icons.videocam, size:30,color: Colors.blue),
          SizedBox(width:20),
          Icon(Icons.photo, size:30,color: Colors.blue),
          SizedBox(width:20),
          Icon(Icons.notifications, size:30,color: Colors.blue)
          ],
        ),
      ),


    );
  }
}
