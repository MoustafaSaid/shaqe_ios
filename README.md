# Shaqe iOS

A motivational quote app for iOS that displays inspiring quotes when you shake your device.

## Features

- 🎯 **Shake to Get Quotes**: Shake your iPhone to receive a new motivational quote
- 💬 **Curated Collection**: Features 15+ inspiring quotes from famous personalities
- 🎨 **Beautiful UI**: Modern SwiftUI interface with gradient backgrounds and smooth animations
- 📱 **Device Motion Detection**: Uses CoreMotion framework for accurate shake detection
- 🎭 **Haptic Feedback**: Provides tactile feedback when a new quote is displayed
- 🖥️ **Simulator Support**: Works in both physical devices and iOS Simulator

## Requirements

- iOS 14.0 or later
- Xcode 12.0 or later
- Swift 5.0 or later

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd shaqe_ios
```

2. Open the project in Xcode:
```bash
open shaqe_ios.xcodeproj
```

3. Select your target device or simulator
4. Build and run the project (⌘R)

## Usage

1. Launch the app
2. Shake your device (or use the simulator shake gesture: Device → Shake)
3. A new motivational quote will appear with a smooth animation
4. Continue shaking to get more quotes!

## Technical Details

- **Framework**: SwiftUI
- **Motion Detection**: CoreMotion (CMMotionManager)
- **Shake Detection**: 
  - Physical devices: Accelerometer-based detection
  - Simulator: UIKit motion event handling
- **Animation**: Spring animations for smooth transitions
- **Haptic Feedback**: UIImpactFeedbackGenerator

## Project Structure

```
shaqe_ios/
├── shaqe_ios/
│   ├── shaqe_iosApp.swift      # App entry point
│   ├── ContentView.swift        # Main view with shake detection
│   └── Assets.xcassets/         # App assets
└── shaqe_ios.xcodeproj/        # Xcode project file
```

## Author

Created by moustafa on 09/11/2025

## License

This project is available for personal use.

