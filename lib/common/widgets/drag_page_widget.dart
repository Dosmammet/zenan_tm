import 'package:flutter/material.dart';

class DragToDismissRoute extends PageRouteBuilder {
  final Widget page;

  DragToDismissRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration:
              Duration(milliseconds: 0), // No default transition
          reverseTransitionDuration: Duration(milliseconds: 0),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child; // No transition as we handle drag manually
  }
}
