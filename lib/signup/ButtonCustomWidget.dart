import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
  ButtonCustomWidget({
    required this.onPressed,
    required this.widget,
    super.key,
  });
  Widget widget;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: widget,
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 8.0)),
      ),
    );
  }
}
