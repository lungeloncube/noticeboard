import 'package:digital_notice_board/share_post.dart';
import 'package:digital_notice_board/users.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'comments.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String LOG_NAME = 'screen.home';

  bool isLiked = false;

  bool isVisible = false;
  bool isMore=false;

  List<User> users = [
    User(
        firstName: "Lungelo",
        lastName: "Ncube",
        url: "assets/one.jpg",
        date: "Mon July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Amanda",
        lastName: "Ncube",
        url: "assets/two.jpg",
        date: "Mon July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Yolanda",
        lastName: "Ndlovu",
        url: "assets/three.jpg",
        date: "Mon July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Lethu",
        lastName: "Timm",
        url: "assets/four.jpg",
        date: "Mon July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Anele",
        lastName: "Moyo",
        url: "assets/five.png",
        date: "Mon July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Aisha",
        lastName: "Ncube",
        url: "assets/six.png",
        date: "Mon July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notice Board",
            style: TextStyle(fontFamily: 'Trebuchet', fontSize: 20)),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(width:10)
        ],
      ),
      body: _buildFeed(width),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SharePost(),
              ));
        },
      ),
    );
  }

  Widget _buildFeed(width) {
    return Container(
      child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(users[index].url),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${users[index].firstName + " " + users[index].lastName}',
                              style: TextStyle(
                                  fontFamily: 'Trebuchet', fontSize: 16)),
                          SizedBox(height:5),
                          Text(users[index].date,
                              style: TextStyle(
                                  fontFamily: 'Trebuchet', fontSize: 14))
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap:(){
                                setState(() {
                                  isMore=!isMore;
                                });
                              },
                              child: Icon(Icons.more_vert,
                                  size: 30, color: isMore?Colors.blue[900]:Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('${users[index].post}' * 30, style:TextStyle(fontFamily: 'Trebuchet', fontSize:14)),
                      SizedBox(height: 15),
                      Container(
                          width: width,
                          child: Image.asset(
                            users[index].media,
                            fit: BoxFit.fill,
                          )),
                      SizedBox(height: 15),

                      Visibility(
                        visible: isVisible,
                        child: Column(
                          children: [],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  child: Row(

                    children: [
                      Expanded(
                          flex: 6,
                          child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, "/comments",

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Comments(
                                      firstName: users[index].firstName,
                                      lastName: users[index].lastName,
                                      date: users[index].date,
                                      post: users[index].post,
                                      media: users[index].media,
                                      url: users[index].url,
                                    ),
                                  ),
                                );

                                // setState(() {
                                //   isVisible=!isVisible;
                                // });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left:16),
                                child: Text("View Comments (5)",style:TextStyle(fontFamily: 'Trebuchet', fontSize:14)),
                              ))),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              icon: Icon(
                                  isLiked
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_alt_outlined,
                                  color: Colors.blue),
                              onPressed: () {
                                setState(() {
                                  isLiked = !isLiked;
                                });
                              })),
                      // child: widget(child: Icon(isLiked?Icons.thumb_up:Icons.thumb_up_alt_outlined, color: Colors.blue))),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.comment, color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
