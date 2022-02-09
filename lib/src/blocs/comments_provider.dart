import 'package:flutter/material.dart';

import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  CommentsBloc bloc = CommentsBloc();

  CommentsProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentsProvider>()!)
        .bloc;
  }
}
