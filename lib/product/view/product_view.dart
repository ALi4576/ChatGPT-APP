import 'package:ai/main.dart';
import 'package:ai/utils/colors.dart';
import 'package:ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController scrollController = ScrollController();
    final productTextEditingController = TextEditingController();
    final productState = ref.watch(productProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });

    return CustomScaffold(
      endDrawer: EndDrawer(
        child: RightMenu(
          heading: 'product',
          examples: const [
            'Find most popular products sold in last month',
          ],
          onExampleTap: () {
            if (productState.isLoading == false) {
              productTextEditingController.text =
                  'Find most popular products sold in last month';
            }
          },
        ),
      ),
      body: Row(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width < 1000
                ? MediaQuery.sizeOf(context).width
                : MediaQuery.sizeOf(context).width * 0.82,
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: AppColors.dividerColor,
                  width: 2,
                ),
                horizontal: BorderSide(
                  color: AppColors.dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                productState.chats.isEmpty
                    ? const SizedBox()
                    : Expanded(
                        child: Scrollbar(
                          controller: scrollController,
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: productState.chats.length,
                            itemBuilder: (context, index) {
                              final chat = productState.chats[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Question(
                                      question: chat.question ?? '',
                                      trailing: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            if (productState.isLoading ==
                                                    false &&
                                                chat.question != null &&
                                                chat.question!.isNotEmpty) {
                                              productTextEditingController
                                                  .text = chat.question!;
                                            }
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    AnswerContainer(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const AiBot(),
                                              Copy(
                                                chat: chat,
                                                lang: ref.watch(
                                                  translationProvider,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          TypewriterText(
                                            key: UniqueKey(),
                                            runTyper: index ==
                                                    productState.chats.length -
                                                        1 &&
                                                !productState.isLoading &&
                                                !productState.isError,
                                            text:
                                                (ref.watch(translationProvider) ==
                                                            'en'
                                                        ? chat.answer?.en
                                                        : chat.answer?.hu) ??
                                                    '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  color: AppColors.textColor,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (productState.isLoading &&
                                        index == productState.chats.length - 1)
                                      ShowQuestion(
                                        question: productState.query,
                                      ),
                                    if (productState.isError &&
                                        index == productState.chats.length - 1)
                                      const Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Error(),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                if (productState.isLoading && productState.chats.isEmpty)
                  Expanded(
                    child: ShowQuestion(
                      question: productState.query,
                    ),
                  ),
                if (productState.isError && productState.chats.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Error(),
                  ),
                if (productState.isError && productState.chats.isEmpty)
                  const Spacer(),
                const SizedBox(height: 5),
                SendQuery(
                  textEditingController: productTextEditingController,
                  onSend: () {
                    if (productState.isLoading == false) {
                      ref
                          .watch(productProvider.notifier)
                          .getProductResponse(
                            productTextEditingController.text,
                          )
                          .then(
                            (value) => productTextEditingController.clear(),
                          );
                    }
                  },
                ),
                const GoAi(),
              ],
            ),
          ),
          if (MediaQuery.sizeOf(context).width > 1000)
            RightMenu(
              heading: 'product',
              examples: const [
                'Find most popular products sold in last month',
              ],
              onExampleTap: () {
                if (productState.isLoading == false) {
                  productTextEditingController.text =
                      'Find most popular products sold in last month';
                }
              },
            ),
        ],
      ),
    );
  }
}
