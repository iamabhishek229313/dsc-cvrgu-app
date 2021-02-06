import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "</Dev Mode>",
        style: TextStyle(fontSize: 34.0),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:vibration/vibration.dart';

// const flashOn = 'FLASH ON';
// const flashOff = 'FLASH OFF';
// const frontCamera = 'FRONT CAMERA';
// const backCamera = 'BACK CAMERA';

// class QRScanner extends StatefulWidget {
//   const QRScanner({
//     Key key,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QRScannereState();
// }

// class _QRScannereState extends State<QRScanner> {
//   var qrText = '';
//   var flashState = flashOn;
//   var cameraState = frontCamera;
//   QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   bool vibrated = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Expanded(
//           flex: 4,
//           child: Material(
//             elevation: 5.0,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderColor: Colors.red,
//                 borderRadius: 10,
//                 borderLength: 30,
//                 borderWidth: 10,
//                 cutOutSize: 300,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text("Point it towards JivDaya QR Code to auto scan"),
//               Material(
//                 borderRadius: BorderRadius.circular(30.0),
//                 elevation: 5.0,
//                 child: Container(
//                     height: 55.0,
//                     width: 150.0,
//                     decoration: BoxDecoration(),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         new IconButton(
//                           onPressed: () {
//                             if (controller != null) {
//                               controller.flipCamera();
//                               if (_isBackCamera(cameraState)) {
//                                 setState(() {
//                                   cameraState = frontCamera;
//                                 });
//                               } else {
//                                 setState(() {
//                                   cameraState = backCamera;
//                                 });
//                               }
//                               _vibrateLow();
//                             }
//                           },
//                           icon: Icon(Icons.switch_camera),
//                         ),
//                         new IconButton(
//                           onPressed: () {
//                             if (controller != null) {
//                               controller.toggleFlash();
//                               if (_isFlashOn(flashState)) {
//                                 setState(() {
//                                   flashState = flashOff;
//                                 });
//                               } else {
//                                 setState(() {
//                                   flashState = flashOn;
//                                 });
//                               }
//                               _vibrateLow();
//                             }
//                           },
//                           icon: Icon(flashState == flashOn ? Icons.flash_on : Icons.flash_off),
//                         )
//                       ],
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   bool _isFlashOn(String current) {
//     return flashOn == current;
//   }

//   bool _isBackCamera(String current) {
//     return backCamera == current;
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData.code;
//         print("Data Received    :   " + qrText);
//         if (vibrated == false) {
//           _vibrate();
//           vibrated = true;
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text("Scanned data"),
//                   content: Text(scanData.code),
//                   actions: [
//                     FlatButton.icon(
//                       label: Text("Try again"),
//                       icon: Icon(Icons.redo),
//                       onPressed: () {
//                         vibrated = false;
//                         Navigator.of(context).pop();
//                       },
//                     )
//                   ],
//                 );
//               });
//         }
//       });
//     });
//   }

//   _vibrate() async {
//     if (await Vibration.hasVibrator()) {
//       print("Virabte");
//       Vibration.vibrate(amplitude: 128, duration: 100);
//     }
//   }

//   _vibrateLow() async {
//     // Having a personalized experience is good ;)
//     if (await Vibration.hasVibrator()) {
//       print("Virabte");
//       Vibration.vibrate(amplitude: 90, duration: 50);
//     }
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
