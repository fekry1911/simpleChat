import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackbarDemo extends StatelessWidget {
  // Custom awesome snackbar function
  void showAwesomeSnackbar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.white,
    IconData icon = Icons.check_circle,
    Duration duration = const Duration(seconds: 10),
  }) {
    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SnackbarDemo();
  }
}
