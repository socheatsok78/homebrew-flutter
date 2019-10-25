# Flutter Homebrew

[Experimental] Homebrew Cask for Flutter

[![Build Status](https://travis-ci.com/socheatsok78/homebrew-flutter.svg?branch=master)](https://travis-ci.com/socheatsok78/homebrew-flutter)

## Installation
```sh
brew tap socheatsok78/flutter
brew cask install flutter
```

or 

```sh
brew cask install socheatsok78/flutter/flutter
```

## Uninstall
To uninstall `flutter` run the following command:
```sh
brew cask zap flutter # Clean all files associated with Flutter SDK
brew cask uninstall flutter
```

## Switching Flutter Channel
To switch to a different channel run the following command:
```sh
flutter channel [stable|dev|beta|master]
flutter upgrade
```

## See also
Other people implementation:
[MiderWong/homebrew-flutter](https://github.com/MiderWong/homebrew-flutter)
[flschweiger/homebrew-flutter](https://github.com/flschweiger/homebrew-flutter)
