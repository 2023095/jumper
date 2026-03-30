import 'dart:async'; 
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/game.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef<Jumper> {
  final bool isTopPipe;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'pipes_top.png' : 'pipes_bottom.png');
    add(RectangleHitbox()); 
  }

  @override
  void update(double dt) {
    position.x -= groundScrollingSpeed * dt;
    if (position.x + size.x <=0) {
      removeFromParent();
    }
  }
}