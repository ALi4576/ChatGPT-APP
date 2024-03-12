import 'package:ai/utils/utils.dart';
import 'package:ai/widgets/widgets.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

void showPopUpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.backDialogColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: const Popup(),
      );
    },
  );
}

void copyToClipboard(String text, BuildContext context) {
  FlutterClipboard.copy(text).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Text copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        width: 300,
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  });
}
