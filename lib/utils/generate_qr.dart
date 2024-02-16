import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGenOverlay {
  final BuildContext context;
  final String data;
  final String restaurantName;

  OverlayEntry? _overlayEntry;

  QRGenOverlay(this.context, this.data, this.restaurantName);

  void showOverlay() {
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  bool isShowing() {
    return _overlayEntry != null;
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlay() {
    return OverlayEntry(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black54,
          body: Center(
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // Adjust size as needed
                height: MediaQuery.of(context).size.height *
                    0.6, // Adjust size as needed

                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0)),
                    color: Color.fromRGBO(60, 45, 68, 1.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QrImageView(
                        data: data,
                        size: MediaQuery.of(context).size.width * 0.70,
                        padding: const EdgeInsets.all(30),
                        backgroundColor: Colors.white,

                      ),
                      Text(restaurantName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight
                                  .bold)), //TODO: ovde eden jak font i prejako ce lici
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: removeOverlay,
                        child: const Text('Close Overlay'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
