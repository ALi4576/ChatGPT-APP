import 'package:flutter/material.dart';
import 'dart:async';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration speed;
  final bool runTyper;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.speed = const Duration(milliseconds: 10),
    this.runTyper = false,
  });

  @override
  TypewriterTextState createState() => TypewriterTextState();
}

class TypewriterTextState extends State<TypewriterText> {
  late TextEditingController _controller;
  late Timer _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.runTyper) {
      _timer = Timer.periodic(widget.speed, (Timer timer) {
        setState(() {
          if (_index < widget.text.length) {
            _controller.text = widget.text.substring(0, _index + 1);
            _index++;
          } else {
            _timer.cancel();
          }
        });
      });
    } else {
      _controller.text = widget.text;
      _timer = Timer(Duration.zero, () {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      _controller.text,
      style: widget.style,
    );
  }
}
