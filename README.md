# F8 - Refresh Hackathon

![Facebook F8 Banner](images/f8-banner.png)

## Getting Started

Clone the project from `master` branch. This app is made for iOS, there is no Android support added to this project. If you try running it for Android, then it would crash.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation

#### Pre-requisites

* Install [Flutter](https://flutter.dev/docs/get-started/install/macos) for macOS.
* Xcode version should be 12.4 and above. Xcode 12.5 is highly preffered.
* VSCode IDE

#### Running the app

* Open the project in VSCode. Make sure that you have Flutter and Dart extensions for Flutter installed within the IDE.

* Connect your simulator and run `cmd+F5` to build the app onto the simulator. You can also connect your physical iPhone and run the build. If Xcode signing error pops up, cd into `ios` folder and open `Runner.xcodeproj` with Xcode and add a team.

## Troubleshooting
* If any error persists while build, then cd into `ios` and run `rm -rf Podfile.lock`. Go back to the root and run `flutter clean` to clean your Flutter builds. Now, cd into `ios` and run `pod install` to install fresh pods.

* If you try running `Runner.xcworkspace` with Xcode, there are chances that it might fail or pop up an error, such as:

```
Undefined symbol: _OBJC_CLASS_$_FlutterError
```
You can however try removing pods and deleting `Runner.xcworkspace` and try building it again, however it's likely that the error would still persists. Hence, there is no point in running `Runner.xcworkspace` with Xcode. This error is due to one of 3rd party pub.dev packages.

* You can also try building the iOS app by running `flutter build ios` and get the `Runner.xarchive` file to run manually on your iPhone.

