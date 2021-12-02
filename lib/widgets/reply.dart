import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:flutter/material.dart';

class Reply extends StatelessWidget {
  const Reply({
    Key key,
    @required this.firstName,
    @required this.lastName,
    @required this.url,
    @required this.post,
    @required this.isLiked,
    @required this.onPressed,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String url;
  final String post;
  final isLiked;
  final Function onPressed;

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
                      child: Avatar(path: url, radius: 20.0)),
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
                        color: Colors.grey[200],
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
                                      Text('${firstName + " " + lastName}',
                                          style: TextStyle(
                                              fontFamily: 'Trebuchet',
                                              fontSize: 18)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.more_vert),
                                          onPressed: () {}),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(post * 20,
                                style: TextStyle(
                                    fontFamily: 'Trebuchet', fontSize: 16)),
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
                            onPressed: onPressed),
                        IconButton(
                          icon: Icon(Icons.reply, color: Colors.blue),
                          onPressed: () {},
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
