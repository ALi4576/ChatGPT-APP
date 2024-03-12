import 'package:ai/utils/utils.dart';
import 'package:ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowQuestion extends StatelessWidget {
  const ShowQuestion({
    super.key,
    required this.question,
  });

  final String question;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Question(
          question: question,
        ),
        const SizedBox(height: 15),
        const GenerateAnswer(),
        const SizedBox(height: 10),
      ],
    );
  }
}

class Question extends StatelessWidget {
  const Question({
    super.key,
    required this.question,
    this.trailing,
  });

  final String question;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Container(
      width: 600,
      padding: const EdgeInsets.fromLTRB(30, 30, 10, 30),
      decoration: BoxDecoration(
        color: AppColors.questionColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: trailing != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              Text(
                tr.you,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 5),
          SelectableText(
            question,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textColor,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}


class Error extends StatelessWidget {
  const Error({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Container(
      width: 600,
      padding: const EdgeInsets.fromLTRB(
        10,
        30,
        10,
        30,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff272350), Color(0xff212046)],
          stops: [0.3, 0.93],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            tr.error,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
          ),
        ],
      ),
    );
  }
}
