import 'package:digital_notice_board/reply.dart';
import 'package:digital_notice_board/users.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class CommentReply extends StatefulWidget {
  final User user;

  const CommentReply({Key key, @required this.user}) : super(key: key);

  @override
  _CommentReplyState createState() => _CommentReplyState();
}

class _CommentReplyState extends State<CommentReply> {
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
              style: TextStyle(fontFamily: 'Trebuchet', fontSize: 20))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 0),
              child: Row(
                children: [
                  Text(
                      'Replies to ${widget.user.firstName} comment on this post.',
                      style: TextStyle(fontFamily: 'Trebuchet', fontSize: 14)),
                ],
              ),
            ),
            Divider(color: Colors.black),
            Reply(firstName: widget.user.firstName, lastName: widget.user.lastName, url: widget.user.url, post: widget.user.post),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: _buildFeed(width),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
          color: Colors.grey[200],
          child: TextFormField(
              maxLines: null,
              //autofocus: true,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Comment")
              // hintText: "@${widget.user.firstName } ${widget.user.lastName}"),
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
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage(users[index].url),
                            ),
                          ),
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
                                                  '${users[index].firstName + " " + users[index].lastName}'),
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
                                                  icon: Icon(Icons.more_vert),
                                                  onPressed: () {}),
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
                                IconButton(
                                    icon: Icon(
                                        true
                                            ? Icons.thumb_up
                                            : Icons.thumb_up_alt_outlined,
                                        color: Colors.blue),
                                    onPressed: () {
                                      // setState(() {
                                      //   isLiked=!isLiked;
                                      // });
                                    }),
                                IconButton(
                                  icon: Icon(Icons.reply, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentReply(
                                          user: users[index],
                                        ),
                                      ),
                                    );
                                    // setState(() {
                                    //   isCommentReply=true;
                                    //   appBarTitle="Reply to Comment";
                                    // });
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


