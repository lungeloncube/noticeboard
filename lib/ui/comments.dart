import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_bloc.dart';
import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_event.dart';
import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_state.dart';
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

class Comments extends StatefulWidget {
  final String firstName;
  final String lastName;
  final DateTime date;
  final String url;
  final String post;
  final String media;
  final postUserId;
  final postId;

  const Comments({
    Key key,
    @required this.firstName,
    @required this.lastName,
    @required this.date,
    @required this.url,
    @required this.post,
    @required this.media,
    @required this.postUserId,
    @required this.postId,
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

  static const String LOG_NAME = 'screen.comments';

  @override
  void initState() {
    super.initState();
    commentBloc = BlocProvider.of<CommentBloc>(context);
    individualPostBloc = BlocProvider.of<IndividualPostBloc>(context);

    individualPostBloc
        .add(FetchPostByIdEvents(postId: widget.postId, branchId: 'BR-1001'));
    _controller = VideoPlayerController.network(widget.media);
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _textController.dispose();
    commentController.dispose();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        tooltip: 'play/pause',
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
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
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the VideoPlayerController has finished initialization, use
                        // the data it provides to limit the aspect ratio of the video.
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        // If the VideoPlayerController is still initializing, show a
                        // loading spinner.
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
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
