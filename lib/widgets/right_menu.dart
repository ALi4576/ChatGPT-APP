import 'package:ai/utils/utils.dart';
import 'package:ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RightMenu extends StatelessWidget {
  const RightMenu({
    super.key,
    required this.examples,
    required this.onExampleTap,
    required this.heading,
  });

  final List<String> examples;
  final VoidCallback onExampleTap;
  final String heading;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 12,
        right: 12,
        bottom: 2,
      ),
      width: MediaQuery.sizeOf(context).width * 0.18,
      height: MediaQuery.sizeOf(context).height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              heading == 'transaction' ? tr.transaction : tr.product,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
            ),
            const Divider(
              color: AppColors.dividerColor,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                showPopUpDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    tr.newChat,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Divider(
              color: AppColors.dividerColor,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                tr.examples,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            for (final example in examples)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: onExampleTap,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    color: AppColors.secondaryColor,
                    child: Text(
                      example,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textColor,
                            fontSize: 14,
                          ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
