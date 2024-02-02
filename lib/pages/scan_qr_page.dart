import "package:flutter/material.dart";
import "package:mobile_scanner/mobile_scanner.dart";


class QrScanner extends StatefulWidget {
  void Function() action;


  QrScanner(this.action, {super.key});

  @override
  QrScannerState createState() =>
      QrScannerState();
}

class QrScannerState extends State<QrScanner> {
  String overlayText = "Please scan QR Code";
  bool camStarted = false;

  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    autoStart: false,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void startCamera() {
    if (camStarted) {
      return;
    }

    controller.start().then((_) {
      if (mounted) {
        setState(() {
          camStarted = true;
        });
      }
    }).catchError((Object error, StackTrace stackTrace) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong! $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void onBarcodeDetect(BarcodeCapture barcodeCapture) {
    final barcode = barcodeCapture.barcodes.last;
    setState(() {
      overlayText = barcodeCapture.barcodes.last.displayValue ??
          barcode.rawValue ??
          'Barcode has no displayable value';

    });
    widget.action();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner with Overlay Example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: camStarted
                  ? Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: MobileScanner(
                      fit: BoxFit.contain,
                      onDetect: onBarcodeDetect,
                      overlay: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Opacity(
                            opacity: 0.7,
                            child: Text(
                              overlayText,
                              style: const TextStyle(
                                backgroundColor: Colors.black26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                      controller: controller,
                      scanWindow: scanWindow,

                    ),
                  ),
                  CustomPaint(
                    painter: QrScannerOverlay(scanWindow),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ValueListenableBuilder<TorchState>(
                            valueListenable: controller.torchState,
                            builder: (context, value, child) {
                              final Color iconColor;

                              switch (value) {
                                case TorchState.off:
                                  iconColor = Colors.black;
                                case TorchState.on:
                                  iconColor = Colors.yellow;
                              }

                              return IconButton(
                                onPressed: () => controller.toggleTorch(),
                                icon: Icon(
                                  Icons.flashlight_on,
                                  color: iconColor,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () => controller.switchCamera(),
                            icon: const Icon(
                              Icons.cameraswitch_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  : const Center(
                child: Text("Tap on Camera to activate QR Scanner"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: camStarted
          ? null
          : FloatingActionButton(
        onPressed: startCamera,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class QrScannerOverlay extends CustomPainter {
  QrScannerOverlay(this.scanWindow);

  final Rect scanWindow;
  final double borderRadius = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    // Create a Paint object for the white border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Adjust the border width as needed

    // Calculate the border rectangle with rounded corners
// Adjust the radius as needed
    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // Draw the white border
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// class QrScanner extends StatelessWidget {
//   final void Function({Object? returnValue}) action;
//
//   const QrScanner({super.key, required this.action});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         MobileScanner(
//           // fit: BoxFit.contain,
//           controller: MobileScannerController(
//             detectionSpeed: DetectionSpeed.noDuplicates,
//             facing: CameraFacing.back,
//             torchEnabled: false,
//           ),
//           overlay: QrScannerOverlay(),
//           onDetect: (capture) {
//             final List<Barcode> barcodes = capture.barcodes;
//
//             debugPrint('Barcode found! ${barcodes[0].rawValue}');
//             // Navigator.pop(context);
//           },
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             alignment: Alignment.bottomCenter,
//             height: 100,
//             color: Colors.black.withOpacity(0.4),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Center(
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width - 120,
//                     height: 50,
//                     child: FittedBox(
//                       child: Text(
//                         'MenuCraft',
//                         overflow: TextOverflow.fade,
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineMedium!
//                             .copyWith(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
