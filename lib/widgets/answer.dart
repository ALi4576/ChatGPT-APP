import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';

class AnswerContainer extends StatelessWidget {
  const AnswerContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: AnimateGradient(
        primaryColors: const [
          Color(0xFFAA3DC0),
          Color(0xFF8943C6),
        ],
        secondaryColors: const [
          Color(0xFF8943C6),
          Color(0xFF7438BC),
        ],
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            width: 600,
            padding: const EdgeInsets.fromLTRB(30, 20, 10, 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff272350), Color(0xff212046)],
                stops: [0.3, 0.93],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
