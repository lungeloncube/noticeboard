import 'dart:async';

import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_bloc.dart';
import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_event.dart';
import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_state.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_bloc.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_event.dart';
import 'package:digital_notice_board/blocs/individual_post_bloc/individual_post_bloc.dart';
import 'package:digital_notice_board/blocs/individual_post_bloc/individual_post_event.dart';
import 'package:digital_notice_board/blocs/individual_post_bloc/individual_post_state.dart';
import 'package:digital_notice_board/data/models/individual_post_response.dart';
import 'package:digital_notice_board/ui/comment_reply.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/icon_button.dart';
import 'package:digital_notice_board/widgets/loading_indicator.dart';
import 'package:digital_notice_board/widgets/search_text_field.dart';
import 'package:digital_notice_board/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

var token =
    "eyJhbGciOiJSUzI1NiIsImtpZCI6IksxIiwicGkuYXRtIjoid2FvMyJ9.eyJzY29wZSI6Im9wZW5pZCIsImNsaWVudF9pZCI6ImludGVsbGlkZWFsIiwiYWdpZCI6ImVMUkdvNEZCckp1UzU4MUplR1kxQlV3TXhoQUpaUm5RIiwiZW1haWxBZGRyZXNzIjoiRGVhbGVyMVVzZXIxVUFUQ0xHWEBtYWlsaW5hdG9yLmNvbSIsInVzZXJuYW1lIjoiRGVhbGVyMVVzZXIxVUFUQ0xHWEBtYWlsaW5hdG9yLmNvbSIsImV4cCI6MTYxMzgyNzM2NH0.VQDuo6ySx0gKf6dPh9Mha309ah1oBdyGz3Qqe2ybIGoDFo1jjROxkWQXy-QAO-b_wL05Vlxm1DyZL-ChKqm_qULtmfnVdg1bTNZmWMLjMkKtkqUfsVdQ6TL1gO4gu3JLGyiZlwef7o9X_BzfCawfhxSjT11PE7xHIOQXFF77wxUIe7PSrISRcJiK18SJftHD5HbaiXlPwPbn8fDA0QMZe24wZSlNUYMGYwt5gA5t7qINayiDq_6kDTJPAGe4nyRcQ0SVX73GQwQyFQBovsPhQhfVMJCCpT5DoN9q-XLNf77hR0PklXzQdItq3w4OoZuF3mwUG3l4JKesJbGQi1e0Ww";

class Comments extends StatefulWidget {
  final String firstName;
  final String lastName;
  final DateTime date;
  final String url;
  final String post;
  final postUserId;
  final postId;
  final mediaType;
  final mediaUrl;

  const Comments({
    Key key,
    @required this.firstName,
    @required this.lastName,
    @required this.date,
    @required this.url,
    @required this.post,
    @required this.postUserId,
    @required this.postId,
    @required this.mediaType,
    @required this.mediaUrl,
  }) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  bool isLiked = false;
  bool isMore = false;
  bool isSearch = false;
  TextEditingController _textController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  CommentBloc commentBloc;
  bool commented;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  IndividualPostBloc individualPostBloc;
  IndividualPostResponse response;
  bool _showController = false;

  Timer _timer;

  static const String LOG_NAME = 'screen.comments';

  @override
  void initState() {
    super.initState();
    commentBloc = BlocProvider.of<CommentBloc>(context);
    individualPostBloc = BlocProvider.of<IndividualPostBloc>(context);

    individualPostBloc
        .add(FetchPostByIdEvents(postId: widget.postId, branchId: 'BR-1001'));

    _controller = VideoPlayerController.network(
        widget.mediaType == 'Video' ? widget.mediaUrl : null,
        httpHeaders: {
          'Authorization': 'Bearer $token',
        },videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _textController.dispose();
    commentController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dev.log('In the comments page', name: LOG_NAME);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? SearchTextField(textController: _textController)
            : Text('Comments',
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
              child: Icon(isSearch ? Icons.cancel : Icons.search,
                  color: Colors.black)),
          SizedBox(width: 10)
        ],
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
                          child: Avatar(
                            radius: 20.0,
                            path: widget.url == ''
                                ? 'assets/avatar.png'
                                : widget.url,
                          )),
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
                      Text(
                          (DateFormat.MMMEd().format(widget.date) +
                              ' ' +
                              (DateFormat.jm()
                                  .format(widget.date)
                                  .toLowerCase())),
                          style:
                              TextStyle(fontFamily: 'Trebuchet', fontSize: 16))
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
                            child: Icon(Icons.more_vert,
                                size: 30,
                                color: isMore ? Colors.blue : Colors.grey))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.post}',
                    style: TextStyle(fontSize: 16, fontFamily: 'Trebuchet'),
                  ),
                  SizedBox(height: 5),
                  widget.mediaType == "Image"
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Image.network(
                            widget.mediaUrl,
                            headers: {
                              'Authorization': 'Bearer $token',
                            },
                            fit: BoxFit.fill,
                          ))
                      :

                  _controller.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: 3/3,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ClosedCaption(text: null),
                        // Here you can also add Overlay capacities
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          padding: EdgeInsets.all(3),
                          colors: VideoProgressColors(
                              playedColor: Theme.of(context).primaryColor),
                        ),
                        Center(
                          child: InkWell(
                            child: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 60,
                            ),
                            onTap: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                                if (_controller.value.isPlaying) _showController = false;
                                setState(() {});
                              });
                            },
                          ),
                        ),

                      ],
                    ),
                  )
                      : Container(
                    height: 250,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )

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
                      child: Text("Comments:",
                          style: TextStyle(
                              fontFamily: 'Trebuchet', fontSize: 16))),
                ],
              ),
            ),
            BlocListener<CommentBloc, CommentState>(
              listener: (context, state) {
                if (state is CommentLoadedState) {
                  BlocProvider.of<AllPostsBloc>(context).add(FetchAllPostsEvents());
                  return state.commented
                      ? individualPostBloc.add(FetchPostByIdEvents(
                          postId: widget.postId, branchId: 'BR-1001'))
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Comment was not added'),
                          ),
                        );
                }
              },
              child: BlocBuilder<IndividualPostBloc, IndividualPostState>(
                builder: (context, state) {
                  if (state is IndividualPostInitial) {
                    return LoadingIndicator();
                  } else if (state is IndividualPostLoadingState) {
                    return LoadingIndicator();
                  } else if (state is IndividualPostLoadedState) {
                    return _buildFeed(
                        width, state.individualPostResponse.comments);
                  } else if (state is IndividualPostErrorState) {
                    return Text("Error occurred");
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
      bottomSheet: Container(
          color: Colors.grey[200],
          child: BorderlessInputField(
            controller: commentController,
            hint: 'Comment',
            maxLines: null,
            onSaved: (text) {
              commentBloc.add(AddCommentEvent(
                  branchId: 'BR-1001',
                  comment: commentController.text,
                  userId: widget.postUserId.toString(),
                  postId: widget.postId));
              commentController.clear();
            },
          )),
    );
  }

  Widget _buildFeed(width, List<Comment> comments) {
    return Container(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return _buildFeedContent(index, context, comments);
          }),
    );
  }

  Column _buildFeedContent(
      int index, BuildContext context, List<Comment> comments) {
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
                      child: Avatar(
                          path: comments[index].users.thumbnailUrl == ''
                              ? 'assets/avatar.png'
                              : comments[index].users.thumbnailUrl,
                          radius: 20.0)),
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
                        color: Colors.grey[100],
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
                                          '${comments[index].users.firstName + " " + comments[index].users.lastName}',
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
                                          icon: Icon(Icons.more_vert,
                                              color: isMore
                                                  ? Colors.blue
                                                  : Colors.grey),
                                          onPressed: () {
                                            setState(() {
                                              isMore = !isMore;
                                            });
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text('${comments[index].commentText}',
                                style: TextStyle(
                                    fontFamily: 'Trebuchet', fontSize: 16)),
                          ],
                        )),
                    _buildCommentActions(context, index, comments),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildCommentActions(
      BuildContext context, int index, List<Comment> comments) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ActionIconButton(
          icon: isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommentReply(
                  comment: comments[index].commentText,
                  commentId: comments[index].commentId,
                  firstName: comments[index].users.firstName,
                  lastName: comments[index].users.lastName,
                  thumbnail: comments[index].users.thumbnailUrl,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
