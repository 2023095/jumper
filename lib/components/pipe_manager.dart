import 'dart:math';
import 'package:flame/components.dart';
import 'package:Flappy_Slime/components/pipe.dart';
import 'package:Flappy_Slime/constants.dart';
import 'package:Flappy_Slime/game.dart';

class PipeManager extends Component with HasGameRef<Jumper>{
  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    if (!gameRef.isStarted) return;

    pipeSpawnTimer += dt;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe(){
    final double screenHeight = gameRef.size.y;

    final double maxPipeHeight = 
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    final double bottomPipeHeight = 
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    final double topPipeHeight = 
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    
    final bottomPipe = Pipe(
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    final topPipe = Pipe(
      Vector2(gameRef.size.x, 0),
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}