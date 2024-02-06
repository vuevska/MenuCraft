import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationUtil{
  static void show(BuildContext context, String message, {ToastificationType type = ToastificationType.info}){
    toastification.show(
      type: type,
      context: context,
      title:
      Text(message),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}