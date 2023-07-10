import 'package:flutter/material.dart';

class customButton2 extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  double width;
  customButton2(
      {super.key, required this.text, required this.onTap, this.width = 250});

  @override
  State<customButton2> createState() => _customButton2State();
}

class _customButton2State extends State<customButton2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.blue),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class customButton3 extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  customButton3({super.key, required this.onTap, required this.text});

  @override
  State<customButton3> createState() => _customButton3State();
}

class _customButton3State extends State<customButton3> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            widget.text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ));
  }
}
