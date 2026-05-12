import 'dart:async';

import 'package:Flappy_Slime/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends TextComponent with HasGameRef<Jumper> {
  ScoreBoard()
    : super(
        text: "Score: 0\nBest: 0",
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.grey.shade900, fontSize: 24),
        ),
      );

  @override
  FutureOr<void> onLoad() {
    // Top left corner with padding, lowered slightly
    position = Vector2(20, 40);
    priority = 100; // Render on top of pipes
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!gameRef.isStarted) {
      return; // Don't show scores before game starts
    }

    final newText = 'Score: ${gameRef.score}\nBest: ${gameRef.highScore}';
    if (text != newText) {
      text = newText;
    }
  }
}
