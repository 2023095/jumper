import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_demo/components/ground.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/game.dart';
import 'pipe.dart';

class Player extends SpriteComponent with CollisionCallbacks {
  Player() 
      : super(
        position: Vector2(playerStartX, playerStartY),
        size: Vector2(60, 40));

  double velocity = 0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('Player.png');

    add(RectangleHitbox());
  }

  void flap() {
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    if (other is Ground) {
      (parent as Jumper).gameOver();
    }

    if (other is Pipe) {
      (parent as Jumper).gameOver();
    }
  }
}