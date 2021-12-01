import 'package:digital_notice_board/share_post.dart';
import 'package:digital_notice_board/users.dart';
import 'package:digital_notice_board/widgets/Icon.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/search_text_field.dart';
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
  bool isMore = false;
  bool isSearch = false;
  TextEditingController _textController = TextEditingController();

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
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dev.log('In the landing page', name: LOG_NAME);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? SearchTextField(textController: _textController)
            : Text('Notice Board',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontFamily: 'Trebuchet',
                )),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            child: Icon(
              isSearch ? Icons.cancel : Icons.search,
              //Icons.search,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10)
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
            return _buildFeedContent(index, width, context);
          }),
    );
  }

  Column _buildFeedContent(int index, width, BuildContext context) {
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
                      child: Avatar(
                        path: users[index].url,
                        radius: 20.0,
                      )),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${users[index].firstName + " " + users[index].lastName}',
                      style: TextStyle(fontFamily: 'Trebuchet', fontSize: 18)),
                  SizedBox(height: 5),
                  Text(users[index].date,
                      style: TextStyle(fontFamily: 'Trebuchet', fontSize: 16))
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMore = !isMore;
                        });
                      },
                      child: ActionIcon(
                        icon: Icons.more_vert,
                        size: 30.0,
                        color: isMore ? Colors.blue : Colors.grey,
                      ),
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
              Text('${users[index].post}' * 30,
                  style: TextStyle(fontFamily: 'Trebuchet', fontSize: 16)),
              SizedBox(height: 15),
              Container(
                  width: width,
                  child: Image.asset(
                    users[index].media,
                    fit: BoxFit.fill,
                  )),
              SizedBox(height: 15),
            ],
          ),
        ),
        _buildFeedActions(context, index),
      ],
    );
  }

  Container _buildFeedActions(BuildContext context, int index) {
    return Container(
        color: Colors.grey[300],
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
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text("View Comments (5)",
                          style: TextStyle(
                              fontFamily: 'Trebuchet', fontSize: 16)),
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
                child: GestureDetector(
                  onTap: () {
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
                  },
                  child: ActionIcon(
                    icon: Icons.comment,
                    size: 24.0,
                  ),
                ))
          ],
        ),
      );
  }
}
