import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final circleY;

  Player({this.circleY});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0, circleY),
        child: Image.asset(
          'lib/images/player.png',
          width: 50,
        ));
  }
}