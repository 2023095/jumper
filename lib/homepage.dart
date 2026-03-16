import 'dart:async';
import 'package:flutter/material.dart';
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

  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {

      height = gravity * time * time + velocity * time;

      
      setState(() {
        circleY = initialPos - height;
      });

      print(circleY);

      if (circleY > 1) {
        timer.cancel();
      }

      time += 0.1;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = circleY;
    }); 
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