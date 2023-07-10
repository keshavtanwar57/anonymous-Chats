import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class customButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  double height;
  double width;
  bool isIcon;
  customButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.height = 55,
      this.width = 250,
      this.isIcon = false});

  @override
  State<customButton> createState() => _customButtonState();
}

class _customButtonState extends State<customButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey.shade900,
          boxShadow: [
            const BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1),
            BoxShadow(
                color: Colors.grey.shade800,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: .5),
          ],
        ),
        child: Center(
          child: widget.isIcon == true
              ? LottieBuilder.asset(
                  'assets/forwardarrow.json',
                  height: 100,
                  width: 100,
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                      color: Color(0xff9d4edd),
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
        ),
      ),
    );
  }
}
