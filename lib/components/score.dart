import 'dart:async';

import 'package:Flappy_Slime/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<Jumper> {
  ScoreText()
    : super(
        text: "Tap to Start",
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.grey.shade900, fontSize: 32),
        ),
      );

  @override
  FutureOr<void> onLoad() {
    // Position "Tap to Start" above the player
    anchor = Anchor.topCenter;
    position = Vector2(
      gameRef.size.x / 2,
      gameRef.player.position.y + 60,
    );
    priority = 100; // Render on top of pipes
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // Only show "Tap to Start" before game starts
    final newText = !gameRef.isStarted ? 'Tap to Start' : '';
    if (text != newText) {
      text = newText;
    }
  }
}
