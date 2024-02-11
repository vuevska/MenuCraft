import "dart:async";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:menu_craft/pages/restaurant/view_menu_page.dart";
import "package:menu_craft/utils/toastification.dart";
import "package:mobile_scanner/mobile_scanner.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";
import "package:toastification/toastification.dart";

import "../models/restaurant_model.dart";
import "../services/db_service.dart";

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  QrScannerState createState() => QrScannerState();
}

class QrScannerState extends State<QrScanner> {

  final _db = DbAuthService();
  String overlayText = "Please scan QR Code";
  bool camStarted = true;

  String? lastScannedBarcode;

  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    autoStart: true,
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 250,
  );

  @override
  void initState() {
    super.initState();
    startCamera();
  }

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

  void onBarcodeDetect(BarcodeCapture barcodeCapture) async {
    final barcode = barcodeCapture.barcodes.last;
    if (lastScannedBarcode != null) {
      return;
    }
    lastScannedBarcode = barcode.rawValue;
    setState(() {
      overlayText = barcodeCapture.barcodes.last.displayValue ??
          barcode.rawValue ??
          'Barcode has no displayable value';
      camStarted = false;
    });
    print(barcode.rawValue);
    //TODO: mozebi ovde podobro ce bidi da klajme link pa ce mozi i bez app da se vidi restorano
    final restaurantId = barcode.rawValue;

    RestaurantModel? restaurant = await _db.checkAndGetRestauraunt(restaurantId ?? '').catchError((onError){
      InterfaceUtils.show(context, "The QR Code is not valid!", type:ToastificationType.error);

      Timer(const Duration(seconds: 5), (){
        lastScannedBarcode = null;
      });
      return Future<RestaurantModel?>.value(null);

    });
    if(restaurant == null || !context.mounted){
      return;
    }

    controller.stop();

    lastScannedBarcode = null;

    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: ViewMenuPage(
          restaurant: restaurant),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    ).then((value){
      controller.start();
    });
    // widget.action();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(fit: StackFit.expand, children: [
              Center(
                child: MobileScanner(
                  fit: BoxFit.fitHeight,
                  onDetect: onBarcodeDetect,
                  overlay: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Opacity(
                        opacity: 1,
                        child: Text(
                          "Please scan a valid QR Code",
                          style: TextStyle(
                            backgroundColor: Colors.black54,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 4824,
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
              // const Padding(
              //   padding: EdgeInsets.all(16.0),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Text("MenuCraft"),
              //   ),
              // ),
            ]),
          ),
        ],
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
