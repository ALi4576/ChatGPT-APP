import 'package:ai/utils/utils.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendQuery extends StatelessWidget {
  const SendQuery({
    super.key,
    required this.textEditingController,
    required this.onSend,
  });

  final TextEditingController textEditingController;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
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
          child: Container(
            padding: const EdgeInsets.all(3),
            width: 700,
            child: TextField(
              controller: textEditingController,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
              onSubmitted: (value) {
                onSend.call();
              },
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    onSend.call();
                  },
                  child: const Icon(
                    Icons.send,
                    color: AppColors.textColor,
                  ),
                ),
                hintText: tr.send,
                hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textColor,
                      fontSize: 18,
                    ),
                filled: true,
                fillColor: AppColors.secondaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
