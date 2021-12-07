import 'package:digital_notice_board/blocs/individual_comment_bloc/individual_comment_bloc.dart';
import 'package:digital_notice_board/blocs/individual_comment_bloc/individual_comment_event.dart';
import 'package:digital_notice_board/blocs/individual_comment_bloc/individual_comment_state.dart';
import 'package:digital_notice_board/blocs/reply_comment_bloc/reply_comment_bloc.dart';
import 'package:digital_notice_board/blocs/reply_comment_bloc/reply_comment_event.dart';
import 'package:digital_notice_board/blocs/reply_comment_bloc/reply_comment_state.dart';
import 'package:digital_notice_board/data/models/comment_response.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/icon_button.dart';
import 'package:digital_notice_board/widgets/loading_indicator.dart';
import 'package:digital_notice_board/widgets/reply.dart';
import 'package:digital_notice_board/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';

class CommentReply extends StatefulWidget {
  final commentId;
  final firstName;
  final lastName;
  final comment;
  final thumbnail;
  // final userId;

  const CommentReply({
    Key key,
    // @required this.user,
    @required this.commentId,
    @required this.firstName,
    @required this.lastName,
    @required this.comment,
    @required this.thumbnail,
    //@required this.userId
  }) : super(key: key);

  @override
  _CommentReplyState createState() => _CommentReplyState();
}

class _CommentReplyState extends State<CommentReply> {
  bool isMore = false;
  bool isLiked = false;
  TextEditingController replyCommentController = TextEditingController();
  IndividualCommentBloc individualCommentBloc;
  CommentResponse commentResponse;
  String branchId = 'BR-1001';

  static const String LOG_NAME = 'screen.commentReply';
  ReplyCommentBloc replyCommentBloc;

  @override
  void initState() {
    // TODO: implement initState

    replyCommentBloc = BlocProvider.of<ReplyCommentBloc>(context);
    individualCommentBloc = BlocProvider.of<IndividualCommentBloc>(context);

    individualCommentBloc.add(FetchCommentByIdEvents(
        commentId: widget.commentId, branchId: 'BR-1001'));
    super.initState();
  }

  @override
  void dispose() {
    replyCommentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dev.log('In comment reply page', name: LOG_NAME);
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
                  Flexible(
                    child: Container(
                      child: Text(
                          "Replies to ${widget.firstName} ${widget.lastName}'s comment on this post.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style:
                              TextStyle(fontFamily: 'Trebuchet', fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black),
            Reply(
              firstName: widget.firstName,
              lastName: widget.lastName,
              url: widget.thumbnail == ''
                  ? 'assets/avatar.png'
                  : widget.thumbnail == null
                      ? 'assets/avatar.png'
                      : widget.thumbnail,
              post: widget.comment,
              isLiked: isLiked,
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
            ),
            BlocListener<ReplyCommentBloc, ReplyCommentState>(
              listener: (context, state) {
                if (state is ReplyCommentLoadedState) {
                  return state.replyCommented
                      ? individualCommentBloc.add(FetchCommentByIdEvents(
                          commentId: widget.commentId, branchId: branchId))
                      : Text("Could not reply");

                  // return state.replyCommented
                  // ? FetchCommentByIdEvents(
                  //     commentId: widget.commentId, branchId: branchId)
                  // : Text("Could not reply");
                }
              },
              child: BlocBuilder<IndividualCommentBloc, IndividualCommentState>(
                builder: (context, state) {
                  if (state is IndividualCommentInitial) {
                    return LoadingIndicator();
                  } else if (state is IndividualCommentLoadingState) {
                    return LoadingIndicator();
                  } else if (state is IndividualCommentLoadedState) {
                    return _buildFeed(width, state.commentResponse.comments);
                  } else if (state is IndividualCommentLoadedState) {
                    return Text("An error occurred");
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
          color: Colors.grey[200],
          child: BorderlessInputField(
            controller: replyCommentController,
            hint: 'Comment',
            maxLines: null,
            onSaved: (text) {
              replyCommentBloc.add(AddCommentReplyEvent(
                  branchId: branchId,
                  comment: replyCommentController.text,
                  commentId: widget.commentId,
                  userId: '-5906054645658519212'));
            },
          )),
    );
  }

  Widget _buildFeed(width, List<CommentResponse> comments) {
    return Container(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: comments.length ?? 0,
          itemBuilder: (context, index) {
            return feedWidget(index, context, comments);
          }),
    );
  }

  Column feedWidget(
      int index, BuildContext context, List<CommentResponse> comments) {
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
                      child: Avatar(
                          path: comments[index].users.thumbnailUrl == ''
                              ? 'assets/avatar.png'
                              : comments[index].users.thumbnailUrl,
                          // path: 'assets/avatar.png',
                          // path: commentResponse.comments[index].comments[index]
                          //             .users.thumbnailUrl ==
                          //         ""
                          //     ? 'assets/avatar.png'
                          //     : commentResponse.comments[index].comments[index]
                          //                 .users.thumbnailUrl ==
                          //             null
                          //         ? 'assets/avatar.png'
                          //         : commentResponse.comments[index]
                          //             .comments[index].users.thumbnailUrl,
                          radius: 16.0)),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    _buildContent(index, comments),
                    _buildActions(context, index, comments),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildActions(
      BuildContext context, int index, List<CommentResponse> comments) {
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
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CommentReply(
            //       comment: comments[index].commentText,
            //       commentId: comments[index].commentId,
            //       firstName: comments[index].users.firstName,
            //       lastName: comments[index].users.lastName,
            //       thumbnail: comments[index].users.thumbnailUrl == ''
            //           ? 'assets/avatar.png'
            //           : widget.thumbnail,
            //     ),
            //   ),
            // );
          },
        ),
      ],
    );
  }

  Container _buildContent(int index, List<CommentResponse> comments) {
    return Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
        color: Colors.grey[200],
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${comments[index].users.firstName + " " + comments[index].users.lastName}',
                          maxLines: null,
                          style:
                              TextStyle(fontFamily: 'Trebuchet', fontSize: 14)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ActionIconButton(
                        icon: Icons.more_vert,
                        onPressed: () {
                          setState(() {
                            isMore = !isMore;
                          });
                        },
                        color: isMore ? Colors.blue : Colors.grey,
                      )
                    ],
                  ),
                )
              ],
            ),
            Text('${comments[index].commentText}'),
          ],
        ));
  }
}
