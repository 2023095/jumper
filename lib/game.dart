import 'dart:async';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/background.dart';
import 'package:flutter_demo/components/ground.dart';
import 'package:flutter_demo/components/pipe_manager.dart';
import 'package:flutter_demo/components/player.dart';
import 'package:flutter_demo/constants.dart';
import 'components/pipe.dart';

class Jumper extends FlameGame with TapDetector, HasCollisionDetection {

  late Player player;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;

  @override
  FutureOr<void> onLoad() {
    background = Background(size);
    add(background);

    player = Player();
    add(player);

    ground = Ground();
    add(ground);

    pipeManager = PipeManager();
    add(pipeManager);
  }



  @override
  void onTap() {
    player.flap();
  }

  bool isGameOver = false;
  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!, 
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }

  void resetGame() {
    player.position = Vector2(playerStartX, playerStartY);
    player.velocity = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}