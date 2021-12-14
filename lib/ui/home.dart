import 'package:digital_notice_board/blocs/all_posts_bloc/all_post_state.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_bloc.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_event.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_bloc.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_event.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_state.dart';
import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:digital_notice_board/ui/comments.dart';
import 'package:digital_notice_board/ui/share_post.dart';
import 'package:digital_notice_board/widgets/Icon.dart';
import 'package:digital_notice_board/widgets/avatar.dart';
import 'package:digital_notice_board/widgets/loading_indicator.dart';
import 'package:digital_notice_board/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController =
      new ScrollController(); // set controller on scrolling
  bool _show = true;
  static const String LOG_NAME = 'screen.home';

  bool isVisible = false;
  bool isMore = false;
  bool isSearch = false;
  TextEditingController _textController = TextEditingController();
  AllPostsBloc allPostsBloc;
  LikePostBloc likePostBloc;
  PostsResponse postsResponse;
  var token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IksxIiwicGkuYXRtIjoid2FvMyJ9.eyJzY29wZSI6Im9wZW5pZCIsImNsaWVudF9pZCI6ImludGVsbGlkZWFsIiwiYWdpZCI6ImVMUkdvNEZCckp1UzU4MUplR1kxQlV3TXhoQUpaUm5RIiwiZW1haWxBZGRyZXNzIjoiRGVhbGVyMVVzZXIxVUFUQ0xHWEBtYWlsaW5hdG9yLmNvbSIsInVzZXJuYW1lIjoiRGVhbGVyMVVzZXIxVUFUQ0xHWEBtYWlsaW5hdG9yLmNvbSIsImV4cCI6MTYxMzgyNzM2NH0.VQDuo6ySx0gKf6dPh9Mha309ah1oBdyGz3Qqe2ybIGoDFo1jjROxkWQXy-QAO-b_wL05Vlxm1DyZL-ChKqm_qULtmfnVdg1bTNZmWMLjMkKtkqUfsVdQ6TL1gO4gu3JLGyiZlwef7o9X_BzfCawfhxSjT11PE7xHIOQXFF77wxUIe7PSrISRcJiK18SJftHD5HbaiXlPwPbn8fDA0QMZe24wZSlNUYMGYwt5gA5t7qINayiDq_6kDTJPAGe4nyRcQ0SVX73GQwQyFQBovsPhQhfVMJCCpT5DoN9q-XLNf77hR0PklXzQdItq3w4OoZuF3mwUG3l4JKesJbGQi1e0Ww";

  @override
  void initState() {
    super.initState();
    allPostsBloc = BlocProvider.of<AllPostsBloc>(context);
    allPostsBloc.add(FetchAllPostsEvents());
    likePostBloc = BlocProvider.of<LikePostBloc>(context);
    handleScroll();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  void showFloationButton() {
    setState(() {
      _show = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      _show = false;
    });
  }

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
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
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Container(
            child: BlocListener<AllPostsBloc, AllPostsState>(
              listener: (context, state) {
                if (state is AllPostsErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: BlocBuilder<AllPostsBloc, AllPostsState>(
                builder: (context, state) {
                  if (state is AllPostsInitial) {
                    return LoadingIndicator();
                  } else if (state is AllPostsLoadingState) {
                    return LoadingIndicator();
                  } else if (state is AllPostsLoadedState) {
                    if (state.postsResponse.posts.isEmpty) {
                      return Center(child: Text("No Posts"));
                    } else {
                      return _buildFeed(width, state.postsResponse);
                    }
                  } else if (state is AllPostsErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "An error occured while fetching the posts",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'CenturyGothicBold',
                            ),
                          ),
                          OutlinedButton.icon(
                            label: Text("Retry"),
                            icon: Icon(Icons.refresh, color: Colors.blue[400]),
                            onPressed: () {
                              allPostsBloc.add(FetchAllPostsEvents());
                            },
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ))),
      floatingActionButton: Visibility(
        visible: _show,
        child: FloatingActionButton(
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
      ),
    );
  }

  Widget _buildFeed(width, PostsResponse postsResponse) {
    return Container(
      child: ListView.builder(
          controller: _scrollController,
          itemCount: postsResponse.posts.length,
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
                              child: Avatar(
                                path: postsResponse
                                            .posts[index].users.thumbnailUrl ==
                                        ''
                                    ? 'assets/avatar.png'
                                    : postsResponse
                                        .posts[index].users.thumbnailUrl,
                                radius: 20.0,
                              )),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${postsResponse.posts[index].users.firstName} ${postsResponse.posts[index].users.lastName}',
                              style: TextStyle(
                                  fontFamily: 'Trebuchet', fontSize: 18)),
                          SizedBox(height: 5),
                          Text(
                              (DateFormat.MMMEd().format(
                                      postsResponse.posts[index].createdAt) +
                                  ' ' +
                                  (DateFormat.jm()
                                      .format(
                                          postsResponse.posts[index].createdAt)
                                      .toLowerCase())),
                              style: TextStyle(
                                  fontFamily: 'Trebuchet', fontSize: 16))
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
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Comments(
                          mediaType:
                          postsResponse.posts[index].mediaFiles[0].type,
                          firstName: postsResponse.posts[index].users.firstName,
                          lastName: postsResponse.posts[index].users.lastName,
                          date: postsResponse.posts[index].createdAt,
                          post: postsResponse.posts[index].postText,
                          url: postsResponse.posts[index].users.thumbnailUrl,
                          postId: postsResponse.posts[index].postId,
                          postUserId: postsResponse.posts[index].users.userId,
                          mediaUrl:
                          postsResponse.posts[index].mediaFiles[0].url,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                      child:
                      Column(
                        children: [
                          Text('${postsResponse.posts[index].postText}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: 'Trebuchet', fontSize: 16)),
                          SizedBox(height: 15),
                          postsResponse.posts[index].mediaFiles.isNotEmpty
                              ? displayMedia(
                                  postsResponse.posts[index].mediaFiles[0].type,
                                  postsResponse.posts[index].mediaFiles[0].url,
                                  postsResponse
                                      .posts[index].mediaFiles[0].thumbnailUrl)
                              : SizedBox(height: 5),
                          SizedBox(height: 15),
                        ],
                      )
                    ),
                ),

                _buildFeedActions(
                    context,
                    index,
                    postsResponse.posts[index].comments,
                    postsResponse.posts[index].postId,
                    postsResponse.posts[index].users.userId.toString(),
                    false,
                    postsResponse),
              ],
            );
          }),
    );
  }

  Container _buildFeedActions(
      BuildContext context,
      int index,
      List<Comment> comments,
      String postId,
      String userId,
      isLiked,
      PostsResponse response) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Comments(
                          mediaType: response.posts[index].mediaFiles[0].type,
                          firstName: response.posts[index].users.firstName,
                          lastName: response.posts[index].users.lastName,
                          date: response.posts[index].createdAt,
                          post: response.posts[index].postText,
                          url: response.posts[index].users.thumbnailUrl,
                          postId: response.posts[index].postId,
                          postUserId: response.posts[index].users.userId,
                          mediaUrl: response.posts[index].mediaFiles[0].url,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text("View Comments (${comments.length})",
                        style:
                            TextStyle(fontFamily: 'Trebuchet', fontSize: 16)),
                  ))),
          Expanded(
              flex: 2,
              child: BlocBuilder<LikePostBloc, LikePostState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      IconButton(
                          icon: Icon(
                              likePostBloc.isLiked
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined,
                              color: Colors.blue),
                          onPressed: () {
                            if (likePostBloc.isLiked) {
                              likePostBloc.add(
                                  UnLikeEvent(userId: userId, postId: postId));
                            } else {
                              likePostBloc.add(
                                  LikeEvent(userId: userId, postId: postId));
                            }
                          }),
                      Text(" ${response.posts[index].likes}",
                          style: TextStyle(
                            fontFamily: 'Trebuchet',
                            color: Colors.blue,
                            fontSize: 12,
                          )),
                    ],
                  );
                },
              )),
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Comments(
                        mediaType: response.posts[index].mediaFiles[0].type,
                        firstName: response.posts[index].users.firstName,
                        lastName: response.posts[index].users.lastName,
                        date: response.posts[index].createdAt,
                        post: response.posts[index].postText,
                        url: response.posts[index].users.thumbnailUrl,
                        postId: response.posts[index].postId,
                        postUserId: response.posts[index].users.userId,
                        mediaUrl: response.posts[index].mediaFiles[0].url,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionIcon(
                      icon: Icons.comment,
                      size: 24.0,
                    ),
                    Text(
                      response.posts[index].comments.length.toString(),
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontFamily: 'Trebuchet'),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget displayMedia(String mediaType, String mediaUrl, String thumbnailUrl) {
    if (mediaType.contains("Image")) {
      print(mediaUrl);
      return Container(
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            mediaUrl,
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/video_thumbnail.png',
            fit: BoxFit.fill,
          ));
    }
  }
}
