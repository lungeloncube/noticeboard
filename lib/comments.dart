import 'package:digital_notice_board/comment_reply.dart';
import 'package:digital_notice_board/users.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class Comments extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String date;
  final String url;
  final String post;
  final String media;

  const Comments(
      {Key key,
      @required this.firstName,
      @required this.lastName,
      @required this.date,
      @required this.url,
      @required this.post,
      @required this.media})
      : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  bool isLiked = false;
  bool isVisible = true;
  bool isCommentReply = false;
  bool isMore=false;

  static const String LOG_NAME = 'screen.comments';

  List<User> users = [
    User(
        firstName: "Lungelo",
        lastName: "Ncube",
        url: "assets/one.jpg",
        date: "Monday July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Stalker",
        lastName: "Stalker",
        url: "assets/two.jpg",
        date: "Monday July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Yolanda",
        lastName: "Ndlovu",
        url: "assets/three.jpg",
        date: "Monday July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Lethu",
        lastName: "Timm",
        url: "assets/four.jpg",
        date: "Monday July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Anele",
        lastName: "Moyo",
        url: "assets/five.png",
        date: "Monday July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg"),
    User(
        firstName: "Aisha",
        lastName: "Ncube",
        url: "assets/six.png",
        date: "Monday July 9, 12:15pm",
        post: "lorem ipsum ",
        media: "assets/post_image.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments",
            style: TextStyle(fontFamily: 'Trebuchet', fontSize: 22)),
        actions: [Icon(Icons.search, color: Colors.black, size:35), SizedBox(width: 10)],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          backgroundImage: AssetImage(widget.url??'assets/avatar.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.firstName + " " + widget.lastName}',
                          style:
                              TextStyle(fontFamily: 'Trebuchet', fontSize: 18)),
                      SizedBox(height: 5),
                      Text(widget.date,
                          style:
                              TextStyle(fontFamily: 'Trebuchet', fontSize: 16))
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(onTap:(){
                          setState(() {
                            isMore=!isMore;
                          });
                        },child: Icon(Icons.more_vert, size: 30, color: isMore?Colors.blue:Colors.grey))
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
                  Text('${widget.post}' * 30),
                  SizedBox(height: 16),
                  Container(
                      width: width,
                      child: Image.asset(
                        widget.media,
                        fit: BoxFit.fill,
                      )),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: Text("Comments:",
                              style: TextStyle(
                                  fontFamily: 'Trebuchet', fontSize: 16)))),
                ],
              ),
            ),
            users.length == 0 ? Container() : _buildFeed(width)
          ],
        ),
      ),
      bottomSheet: Container(
          color: Colors.grey[300],
          child: BorderlessInputField(
            hint: 'Comment',
            maxLines: null,
          )),
    );
  }

  Widget _buildFeed(width) {
    return Container(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.grey,
                              child:
                                  Avatar(path: users[index].url, radius: 20.0)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                                color: Colors.grey[300],
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${users[index].firstName + " " + users[index].lastName}',
                                                  style: TextStyle(
                                                      fontFamily: 'Trebuchet',
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  icon: Icon(Icons.more_vert, color: isMore?Colors.blue:Colors.grey),
                                                  onPressed: () {
                                                    setState(() {
                                                      isMore=!isMore;
                                                    });

                                                  }),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Text('${users[index].post}' * 20,
                                        style: TextStyle(
                                            fontFamily: 'Trebuchet',
                                            fontSize: 16)),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    icon: Icon(
                                        isLiked
                                            ? Icons.thumb_up
                                            : Icons.thumb_up_alt_outlined,
                                        color: Colors.blue),
                                    onPressed: () {
                                      setState(() {
                                        isLiked = !isLiked;
                                      });
                                    }),
                                IconButton(
                                  icon: Icon(Icons.reply, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentReply(
                                          user: users[index],
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      isCommentReply = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
