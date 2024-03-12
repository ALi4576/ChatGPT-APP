import 'package:ai/model/model.dart';
import 'package:ai/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Copy extends StatelessWidget {
  const Copy({
    super.key,
    required this.chat,
    required this.lang,
  });

  final Chat chat;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          copyToClipboard(
              (lang == 'en' ? chat.answer?.en : chat.answer?.hu) ?? '',
              context);
        },
        child: const Icon(
          Icons.copy,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
