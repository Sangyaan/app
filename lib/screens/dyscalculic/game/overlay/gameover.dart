import 'package:app/screens/dyscalculic/game/game/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// [gameOver] display the gameover menu where the player can restart a new game
OverlayWidgetBuilder gameOver = (BuildContext context, Game game) {
  return Center(
    child: SizedBox(
      width: 200,
      height: 200,
      child: Card(
        child: Center(
          child: Column(
            children: [
              const Text(
                'Game Over',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              /// pauseButton is added and a new game is started by resuming
              /// game engine
              IconButton(
                  onPressed: () {
                    game.overlays.remove("GameOver");
                    game.overlays.add("PauseButton");
                    RunnerGame().resetGame();
                    game.resumeEngine();
                  },
                  icon: const Icon(Icons.replay,
                      size: 48, color: Color(0xFF000000)))
            ],
          ),
        ),
      ),
    ),
  );
};
