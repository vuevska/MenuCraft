import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class InterfaceUtils {
  static OverlayEntry? overlayEntry;

  static void show(BuildContext context, String message,
      {ToastificationType type = ToastificationType.info}) {
    toastification.show(
      type: type,
      context: context,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  static void loadingOverlay(BuildContext context) {
    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        return FadeIn(
          child: const Material(
            color: Colors.black54,
            child: Center(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Uploading your image... Please wait!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10), // Adding some space between text and CircularProgressIndicator
                    CircularProgressIndicator(color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  static void removeOverlay(context) {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }
}
