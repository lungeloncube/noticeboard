import 'package:digital_notice_board/blocs/all_posts_bloc/all_post_state.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_bloc.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_event.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_bloc.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_event.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_state.dart';
import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:digital_notice_board/ui/comments.dart';
import 'package:digital_notice_board/ui/share_post.dart';
import 'package:digital_notice_board/ui/users.dart';
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

  bool isLiked = false;
  bool isVisible = false;
  bool isMore = false;
  bool isSearch = false;
  TextEditingController _textController = TextEditingController();
  AllPostsBloc allPostsBloc;
  LikePostBloc likePostBloc;
  PostsResponse postsResponse;

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
  void initState() {
    super.initState();

    allPostsBloc = BlocProvider.of<AllPostsBloc>(context);
    allPostsBloc.add(FetchAllPostsEvents());

    likePostBloc = BlocProvider.of<LikePostBloc>(context);
    print("event triggered");
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
        leading: null,
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
                    return _buildFeed(width, state.postsResponse);
                  } else if (state is AllPostsErrorState) {
                    return Center(
                      child: Container(
                        height: 600,
                        width: double.infinity,
                        child: Center(
                          child: Column(
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
                                icon: Icon(Icons.refresh,
                                    color: Colors.blue[400]),
                                onPressed: () {
                                  allPostsBloc.add(FetchAllPostsEvents());
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );

                    // buildErrorUi(state.message);
                  }
                  return Container();
                },
              ),
            ),
          ))),
      //_buildFeed(width),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('${postsResponse.posts[index].postText}',
                          style:
                              TextStyle(fontFamily: 'Trebuchet', fontSize: 16)),
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
                _buildFeedActions(
                    context,
                    index,
                    postsResponse.posts[index].comments,
                    postsResponse.posts[index].postId,
                    postsResponse.posts[index].users.userId.toString(),
                    isLiked,
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
      bool isLiked,
      PostsResponse response) {
    return Container(
      color: Colors.grey[200],
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
                          firstName: response.posts[index].users.firstName,
                          lastName: response.posts[index].users.lastName,
                          date: response.posts[index].createdAt,
                          post: response.posts[index].postText,
                          media: users[index].media,
                          url: response.posts[index].users.thumbnailUrl,
                          comments: response.posts[index].comments,
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
                if (state is LikePostLoadedState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                              state.liked
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined,
                              color: Colors.blue),
                          onPressed: () {
                            setState(() {
                              isLiked = state.liked;
                            });

                            isLiked
                                ? likePostBloc.add(
                                    LikeEvent(userId: userId, postId: postId))
                                : null;
                          }),
                      Text(
                        response.posts[index].likes.toString(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontFamily: 'Trebuchet'),
                      )
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                          isLiked
                              ? likePostBloc.add(
                                  LikeEvent(userId: userId, postId: postId))
                              : null;
                        }),
                    Text(
                      response.posts[index].likes.toString(),
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontFamily: 'Trebuchet'),
                    )
                  ],
                );
              },
            ),
          ),
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Comments(
                        firstName: response.posts[index].users.firstName,
                        lastName: response.posts[index].users.lastName,
                        date: response.posts[index].createdAt,
                        post: response.posts[index].postText,
                        media: users[index].media,
                        url: response.posts[index].users.thumbnailUrl,
                        comments: response.posts[index].comments,
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
}
