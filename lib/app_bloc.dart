import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_bloc.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_repository.dart';
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
            allPostsRepository:RepositoryProvider.of<AllPostsRepository>(context),
          ),
        ),

      ],
      child: app,
    );
  }
}
