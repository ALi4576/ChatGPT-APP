import 'package:ai/home/home.dart';
import 'package:ai/main.dart';
import 'package:ai/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomScaffold extends ConsumerWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.endDrawer,
  });

  final Widget body;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.backgroundColor,
        shadowColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: AppColors.dividerColor,
            height: 2,
          ),
        ),
        actions: MediaQuery.sizeOf(context).width > 1000
            ? [
                InkWell(
                  onTap: () {
                    ref.read(translationProvider.notifier).changeLanguage('en');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/en.png', fit: BoxFit.contain),
                        const SizedBox(width: 5),
                        const Text(
                          'EN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    ref.read(translationProvider.notifier).changeLanguage('hu');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/hu.jpg', fit: BoxFit.contain),
                        const SizedBox(width: 5),
                        const Text(
                          'HU',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ]
            : null,
        leadingWidth: 150,
        leading: InkWell(
          onTap: () {
            if (body is HomeScreen) {
              return;
            }
            context.go('/');
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 5),
            child: Image.asset(
              'assets/goai3.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      endDrawer: MediaQuery.sizeOf(context).width < 1000 ? endDrawer : null,
      body: body,
    );
  }
}
