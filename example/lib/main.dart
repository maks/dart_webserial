import 'package:flutter/material.dart';
import 'package:webserial/webserial.dart';
import 'dart:js_interop';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  void chooseSerialDevice() async {
    late final JSSerialPort? port;
    try {
      port = await requestWebSerialPort();
      print("got serial port: $port");
    } catch (e) {
      print(e);
      return;
    }

    if (port?.readable == null) {
      // Open the serial port.
      await port
          ?.open(
            JSSerialOptions(
              baudRate: 115200,
              dataBits: 8,
              stopBits: 1,
              parity: "none",
              bufferSize: 64,
              flowControl: "none",
            ),
          )
          .toDart;

      print("port opened: ${port?.readable}");
    } else {
      print("port already opened: ${port?.readable}");
    }
    // Listen to data coming from the serial device.
    final reader = port?.readable?.getReader() as ReadableStreamDefaultReader;

    while (true) {
      final result = await reader.read().toDart;
      if (result.done) {
        // Allow the serial port to be closed later.
        reader.releaseLock();
        break;
      } else {
        // value is a Uint8Array.
        print("DATA: ${result.value}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MaterialButton(
            child: Text("choose serial port"),
            onPressed: () {
              chooseSerialDevice();
            },
          ),
        ),
      ),
    );
  }
}

@JS()
external set dartSerialDataCallback(JSFunction value);

void onSerialData(JSUint8Array data) {
  print("$data");
}
