import 'dart:async';
import 'package:Flappy_Slime/components/score.dart';
import 'package:Flappy_Slime/components/scoreboard.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:Flappy_Slime/components/background.dart';
import 'package:Flappy_Slime/components/ground.dart';
import 'package:Flappy_Slime/components/pipe_manager.dart';
import 'package:Flappy_Slime/components/player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/pipe.dart';

class Jumper extends FlameGame with TapDetector, HasCollisionDetection {
  late Player player;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;
  late ScoreBoard scoreBoard;

  int score = 0;
  int highScore = 0;
  bool isGameOver = false;
  bool isStarted = false;

  @override
  Future<void> onLoad() async {
    background = Background(size);
    add(background);

    player = Player();
    add(player);

    ground = Ground();
    add(ground);

    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);

    scoreBoard = ScoreBoard();
    add(scoreBoard);

    await _loadHighScore();
  }

  @override
  void onTap() {
    if (isGameOver) return;

    if (!isStarted) {
      isStarted = true;
    }

    player.flap();
  }

  void incrementScore() {
    score += 1;
    if (score > highScore) {
      highScore = score;
      _saveHighScore();
    }
    debugPrint("Score: $score | High Score: $highScore");
  }

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;

    if (score > highScore) {
      highScore = score;
      _saveHighScore();
    }

    pauseEngine();

    showDialog(
      context: buildContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("Score: $score\nHigh Score: $highScore"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    // Center player on screen, positioned higher
    player.position = Vector2(
      (size.x - player.size.x) / 2,
      (size.y - player.size.y) / 2 - 50, // 50 pixels higher
    );
    player.velocity = 0;
    score = 0;
    isGameOver = false;
    isStarted = false;
    ground.position.x = 0;
    pipeManager.pipeSpawnTimer = 0;
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    highScore = prefs.getInt('high_score') ?? 0;
  }

  Future<void> _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('high_score', highScore);
  }
}
