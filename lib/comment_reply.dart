import 'file:///C:/Users/Dell%206/Documents/GitHub/digital_notice_board/lib/widgets/reply.dart';
import 'package:digital_notice_board/users.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/icon_button.dart';
import 'package:digital_notice_board/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class CommentReply extends StatefulWidget {
  final User user;

  const CommentReply({Key key, @required this.user}) : super(key: key);

  @override
  _CommentReplyState createState() => _CommentReplyState();
}

class _CommentReplyState extends State<CommentReply> {
  bool isMore = false;
  bool isLiked = false;
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
  static const String LOG_NAME = 'screen.commentReply';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text("Reply to Comment",
              style: TextStyle(fontFamily: 'Trebuchet', fontSize: 22))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 0),
              child: Row(
                children: [
                  Text(
                      'Replies to ${widget.user.firstName}"s comment on this post.',
                      style: TextStyle(fontFamily: 'Trebuchet', fontSize: 16)),
                ],
              ),
            ),
            Divider(color: Colors.black),
            Reply(
              firstName: widget.user.firstName,
              lastName: widget.user.lastName,
              url: widget.user.url,
              post: widget.user.post,
              isLiked: isLiked,
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },

            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: _buildFeed(width),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
          color: Colors.grey[200],
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
                              radius: 18,
                              backgroundColor: Colors.grey,
                              child:
                                  Avatar(path: users[index].url, radius: 16.0)),
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
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              ActionIconButton(
                                                icon: Icons.more_vert,
                                                onPressed: () {
                                                  setState(() {
                                                    isMore = !isMore;
                                                  });
                                                },
                                                color: isMore
                                                    ? Colors.blue
                                                    : Colors.grey,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Text('${users[index].post}' * 20),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ActionIconButton(
                                  icon: isLiked
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_alt_outlined,
                                  color: Colors.blue,
                                  onPressed: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                ),
                                ActionIconButton(
                                  icon: Icons.reply,
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentReply(
                                          user: users[index],
                                        ),
                                      ),
                                    );
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
