import 'package:digital_notice_board/data/repositories/post_repository/post_provider.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' show Client;

class AppRepositories extends StatelessWidget {
  final Widget appBloc;

  const AppRepositories({
    @required this.appBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => AllPostsRepository(
                allPostsProvider: AllPostsProvider(client: Client())))
      ],
      child: appBloc,
    );
  }
}
