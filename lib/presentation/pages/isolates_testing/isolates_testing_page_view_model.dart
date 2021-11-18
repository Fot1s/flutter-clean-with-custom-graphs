import 'dart:ffi';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

class IsolatesTestingPageViewModel extends BaseViewModel {
  final String title = "Isolates Testing" ;

  bool _running = false ;

  String get startStopTitle => _running ? "Stop" : "Start" ;

  toggleTesting() async {
    _running = !_running ;

    if (_running)  {
      ReceivePort receivePort = ReceivePort();
      compute(doHeavyComputation,null).then((value) => print("Compute returned: $value")) ;

      var isolate = await Isolate.spawn(doHeavyComputation,receivePort.sendPort) ;
      receivePort.listen((message) {
        print("Isolate returned: $message");
        receivePort.close();
        isolate.kill();
      });
    }
    notifyListeners();
  }

  static int doHeavyComputation(SendPort? port) {
    int j = 0 ;
    for (int i = 0 ; i < 1000000000 ; i ++) {
      j += i ;
    }
    port?.send(j) ;
    return j ;
  }
}