import 'dart:js_interop';
import 'package:web/web.dart' as web;
export 'package:web/web.dart'
    show ReadableStreamDefaultReader, WritableStreamDefaultWriter, EventHandler;

Future<JSSerialPort?> requestWebSerialPort() async =>
    await web.window.navigator.serial.requestPort().toDart;

extension on web.Navigator {
  external JSSerial get serial;
}

extension type JSSerial._(JSObject _) implements web.EventTarget, JSObject {
  external JSPromise<JSSerialPort?> requestPort();
  external web.EventHandler? onconnect;
  external web.EventHandler? ondisconnect;
  external JSPromise<JSArray<JSSerialPort?>> getPorts();
}

extension type JSSerialPortRequestOptions._(JSObject _) implements JSObject {}

extension type JSSerialOptions._(JSObject _) implements JSObject {
  external JSSerialOptions({
    required int baudRate,
    required int dataBits,
    required int stopBits,
    required String parity,
    required int bufferSize,
    required String flowControl,
  });

  external int baudRate;
  external int dataBits;
  external int stopBits;

  /// An enumerated property, only accepting the
  /// following values
  /// as a string:
  ///
  /// - `'none'` No parity bit is sent for each data word.
  /// - `'even'` Data word plus parity bit has even parity.
  /// - `'odd'` Data word plus parity bit has odd parity.
  external String parity;
  external int bufferSize;

  /// An enumerated property, only accepting the
  /// following values
  /// as a string:
  ///
  /// - `'none'` No flow control is enabled.
  /// - `'hardware'` Hardware flow control using the RTS and CTS signals is enabled.
  external String flowControl;
}

extension type JSSerialPort._(JSObject _) implements JSObject {
  external web.EventHandler? onconnect;
  external web.EventHandler? ondisconnect;

  external JSPromise open(JSSerialOptions options);

  external JSBoolean get connected;

  external web.ReadableStream? readable;
  external web.WritableStream? writable;

  external JSPromise close();
  external JSPromise forget();

  //TODO
  // SerialPortInfo getInfo();
  // Promise<undefined> setSignals(optional SerialOutputSignals signals = {});
  // Promise<SerialInputSignals> getSignals();
}
