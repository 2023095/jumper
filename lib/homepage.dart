import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_demo/barrier.dart';
import 'package:flutter_demo/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double circleY = 0;
  double initialPos = circleY;
  double height = 0;
  double time = 0;
  double gravity = -2.45; //gravity strength
  double velocity = 3; //jump strength
  double circleWidth = 0.1;
  double circleHeight = 0.1;

  bool gameHasStarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeigth = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 100), (timer) {

      height = gravity * time * time + velocity * time;

      setState(() {
        circleY = initialPos - height;
      });

    if (circleIsDead()) {
      timer.cancel();
      _showDialog();
    }

      moveMap();

      time += 0.1;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = circleY;
    }); 
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      circleY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = circleY;
    });
  }

  void _showDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.brown,
        title: Center(
          child: Text(
            "G A M E  O V E R",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: resetGame,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(7),
                color: Colors.white,
                child: Text(
                  "PLAY AGAIN",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
            ),
          )
        ],
      );
    });
}

  bool circleIsDead() {
    if (circleY < -1 || circleY > 1) {
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= circleWidth &&
          barrierX[i] +  barrierWidth >= -circleWidth &&
          (circleY <= -1 + barrierHeigth[i] [0] ||
              circleY + circleHeight >= 1 - barrierHeigth[i][1])) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      Player(
                        circleY: circleY,
                        circleWidth: circleWidth,
                        circleHeight: circleHeight,
                      ),

                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeigth[0][0],
                        isThisBottomBarrier: false,
                      ),

                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeigth[0][1],
                        isThisBottomBarrier: true,
                      ),

                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeigth[1][0],
                        isThisBottomBarrier: false,
                      ),

                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeigth[1][1],
                        isThisBottomBarrier: true,
                      ),

                      Container(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            gameHasStarted ? '' : 'T A P  T O  P L A Y',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}