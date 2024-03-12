import 'package:ai/utils/utils.dart';
import 'package:flutter/material.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: child,
    );
  }
}
