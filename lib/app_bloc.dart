import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_bloc.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_bloc.dart';
import 'package:digital_notice_board/blocs/individual_comment_bloc/individual_comment_bloc.dart';
import 'package:digital_notice_board/blocs/individual_post_bloc/individual_post_bloc.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_bloc.dart';
import 'package:digital_notice_board/blocs/reply_comment_bloc/reply_comment_bloc.dart';
import 'package:digital_notice_board/blocs/share_post/share_post_bloc.dart';
import 'package:digital_notice_board/data/repositories/add_comment_repository/add_comment_repository.dart';
import 'package:digital_notice_board/data/repositories/comment_reply_repository/comment_reply_repository.dart';
import 'package:digital_notice_board/data/repositories/like_post_repository/like_post_repository.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_repository.dart';
import 'package:digital_notice_board/data/repositories/share_post_repository/share_post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocs extends StatelessWidget {
  final Widget app;

  const AppBlocs({@required this.app});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllPostsBloc(
            allPostsRepository:
                RepositoryProvider.of<AllPostsRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => LikePostBloc(
            likePostRepository:
                RepositoryProvider.of<LikePostRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => CommentBloc(
            addCommentRepository:
                RepositoryProvider.of<AddCommentRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ReplyCommentBloc(
            replyCommentRepository:
                RepositoryProvider.of<ReplyCommentRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => IndividualPostBloc(
            allPostsRepository:
                RepositoryProvider.of<AllPostsRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => IndividualCommentBloc(
            allPostsRepository:
                RepositoryProvider.of<AllPostsRepository>(context),
          ),
        ),

        BlocProvider(
          create: (context) => SharePostBloc(
            sharePostRepository:
            RepositoryProvider.of<SharePostRepository>(context),
          ),
        ),
      ],
      child: app,
    );
  }
}
