import 'package:flutter/material.dart';

class Reply extends StatelessWidget {
  const Reply({
    Key key,
    @required this.firstName,
    @required this.lastName,
    @required this.url,
    @required this.post,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String url;
  final String post;

  @override
  Widget build(BuildContext context) {
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
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(url),
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
                                          '${firstName + " " +lastName}',
                                          style: TextStyle(
                                              fontFamily: 'Trebuchet',
                                              fontSize: 16)),
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
                            Text(post* 20,style:TextStyle(fontFamily: 'Trebuchet', fontSize:14)),
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
                              // isLiked=!isLiked;
                              // });
                            }),
                        IconButton(
                          icon: Icon(Icons.reply, color: Colors.blue),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            // MaterialPageRoute(
                            //   builder: (context) => CommentReply(
                            //     user: widget.user,
                            //   ),
                            // ),
                            // );
                            // setState(() {
                            // isCommentReply=true;
                            // appBarTitle="Reply to Comment";
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
  }
}