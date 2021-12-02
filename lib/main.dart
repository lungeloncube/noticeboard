import 'package:digital_notice_board/app_bloc.dart';
import 'package:digital_notice_board/app_repositories.dart';
import 'package:digital_notice_board/ui/comment_reply.dart';
import 'package:digital_notice_board/ui/comments.dart';
import 'package:digital_notice_board/ui/home.dart';
import 'package:digital_notice_board/ui/landing_page.dart';
import 'package:digital_notice_board/ui/reminder.dart';
import 'package:digital_notice_board/ui/share_post.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

Future<void> main() async {
  runApp(AppRepositories(
    appBloc: AppBlocs(app: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  static const String LOG_NAME = 'screen.main';
  @override
  Widget build(BuildContext context) {
    dev.log('In main.dart', name: LOG_NAME);
    return MaterialApp(
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => LandingPage(),
        '/home': (context) => HomePage(),
        '/comments': (context) => Comments(),
        '/sharePost': (context) => SharePost(),
        '/reminder': (context) => ReminderPage(),
        '/reply': (context) => CommentReply(),
      },
    );
  }
}
