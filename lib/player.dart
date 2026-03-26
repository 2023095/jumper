import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final circleY;
  final double circleWidth;
  final double circleHeight;

  Player({this.circleY, required this.circleWidth, required this.circleHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0, (2 * circleY + circleHeight) / (2 - circleHeight)),
        child: Image.asset(
          'lib/images/player.png',
          width: MediaQuery.of(context).size.height * circleWidth / 2,
          height: MediaQuery.of(context).size.height * 3 / 4 * circleHeight / 2,
          fit: BoxFit.fill,
        ));
  }
}