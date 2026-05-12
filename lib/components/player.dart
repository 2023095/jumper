import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:Flappy_Slime/components/ground.dart';
import 'package:Flappy_Slime/constants.dart';
import 'package:Flappy_Slime/game.dart';
import 'pipe.dart';

class Player extends SpriteComponent with CollisionCallbacks {
  Player()
    : super(
        position: Vector2(playerStartX, playerStartY),
        size: Vector2(60, 40),
      );

  double velocity = 0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('Player.png');
    add(RectangleHitbox());

    // Center player on screen, positioned higher
    final game = parent as Jumper;
    position = Vector2(
      (game.size.x - size.x) / 2,
      (game.size.y - size.y) / 2 - 50, // 50 pixels higher
    );
  }

  void flap() {
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    final game = parent as Jumper;
    if (!game.isStarted) return;

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
