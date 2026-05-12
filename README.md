# Jumper Game

[![Flutter](https://img.shields.io/badge/Flutter-3.16+-blue.svg)](https://flutter.dev)
[![Flame](https://img.shields.io/badge/Flame-1.11+-orange.svg)](https://flame-engine.org)
[![Dart](https://img.shields.io/badge/Dart-3.0+-teal.svg)](https://dart.dev)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20Android-lightgrey)]()

> A side-scrolling jumper game built with Flutter & Flame Engine - tap to jump, avoid pipes, and beat your high score!

![Gameplay Demo](https://via.placeholder.com/800x400?text=Jumper+Game+Screenshot)
*[![alt text](Screenshot_1775706005.png)]*

## 🎮 About The Project

**Jumper** is an addictive endless runner game where you control a character navigating through procedurally generated pipes. Built entirely with Flutter and the Flame game engine, it demonstrates real-time collision detection, infinite scrolling mechanics, and responsive touch controls.

### Technical Highlights
- ⚡ Real-time game loop
- ♾️ Endless procedural level generation
- 📱 Cross-platform (iOS & Android)

## 🛠️ Built With

| Category | Technologies |
|----------|-------------|
| **Framework** | Flutter 3.16+ |
| **Game Engine** | Flame 1.11+ |
| **Language** | Dart 3.0+ |
| **Collision** | Flame Forge2D |
| **Rendering** | Custom Sprite Components |

## ✨ Features

- **Infinite Scrolling** - Ground and obstacles scroll continuously
- **Procedural Generation** - Pipes spawn randomly with varying heights
- **Collision Detection** - Real-time hitbox detection for ground and pipes
- **Game States** - Start screen, active gameplay, and game over states
- **Responsive Controls** - Tap anywhere to jump

## 📸 Visual Preview

| Start Screen | Gameplay | Game Over |
|-------------|----------|-----------|
| ![Start](https://via.placeholder.com/250x444?text=Tap+to+Start) | ![Gameplay](https://via.placeholder.com/250x444?text=Game+Screen) | ![Game Over](https://via.placeholder.com/250x444?text=Game+Over) |

## 🚀 Getting Started

### Prerequisites

```bash
# Install Flutter SDK
curl -s https://raw.githubusercontent.com/flutter/flutter/main/install.sh | bash

# Verify installation
flutter doctor

# You should see:
✓ Flutter (Channel stable, 3.16+)
✓ Android toolchain
✓ iOS toolchain
✓ Android Studio / VS Code