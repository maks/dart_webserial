# WebSerial Dart package


A Dart package for the [Web Serial API](https://wicg.github.io/serial/), built on top of the web package. This package exists only because the web package only supports Web APIs that are standardised by the [W3C](https://www.w3.org/) or are on the W3C Standards Track, which for now the Web Serial API is not.


## Using the package

1. Add `webserial: ^0.1.0` to your pubspec.yaml file.
2. Import `package:webserial/webserial.dart` in your Flutter app.

Note that this package builds on top of the web package, so some of the types come from the web package but you can still use them without importing `package:web/web.dart` because they are re-exported by webserial package.


## Usage

See example Flutter app in `/example` folder. 

