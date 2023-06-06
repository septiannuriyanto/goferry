import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goferry/text_theme.dart';

errorMessage(Object e) {
  Get.snackbar("Error", "Error Message",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
      titleText: const Text(
        'Error has Occured',
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(
        e.toString(),
        style: const TextStyle(color: Colors.white),
      ));
}

customErrorMessage(String title, String message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.redAccent.withOpacity(0.2),
    snackPosition: SnackPosition.BOTTOM,
    titleText: Text(
      title,
      style: textTheme.labelSmall!.copyWith(color: Colors.red.shade900),
    ),
    messageText: Text(
      message,
      style: TextStyle(color: Colors.red.shade900),
    ),
    duration: const Duration(seconds: 2),
    barBlur: 10,
  );
}

customSuccessMessage(String title, String message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.greenAccent.withOpacity(0.5),
    snackPosition: SnackPosition.BOTTOM,
    titleText: Text(
      title,
      style: textTheme.labelSmall!.copyWith(color: Colors.green.shade900),
    ),
    messageText: Text(
      message,
      style: TextStyle(color: Colors.green.shade900),
    ),
    duration: const Duration(seconds: 2),
    barBlur: 10,
  );
}
