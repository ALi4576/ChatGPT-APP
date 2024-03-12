import 'package:ai/main.dart';
import 'package:ai/utils/utils.dart';
import 'package:ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController scrollController = ScrollController();
    final transactionTextEditingController = TextEditingController();
    final tranState = ref.watch(transactionProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });

    return CustomScaffold(
      endDrawer: EndDrawer(
        child: RightMenu(
          heading: 'transaction',
          examples: const [
            'Find most popular products sold in last month',
          ],
          onExampleTap: () {
            if (tranState.isLoading == false) {
              transactionTextEditingController.text =
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
                tranState.chats.isEmpty
                    ? const SizedBox()
                    : Expanded(
                        child: Scrollbar(
                          controller: scrollController,
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: tranState.chats.length,
                            itemBuilder: (context, index) {
                              final chat = tranState.chats[index];
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
                                            if (tranState.isLoading == false &&
                                                chat.question != null &&
                                                chat.question!.isNotEmpty) {
                                              transactionTextEditingController
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
                                          if (chat.answer?.graph != null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              child: Image.network(
                                                chat.answer?.graph ?? '',
                                                width: 500,
                                                height: 300,
                                              ),
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            child: TypewriterText(
                                              key: UniqueKey(),
                                              runTyper: index ==
                                                      tranState.chats.length -
                                                          1 &&
                                                  !tranState.isLoading &&
                                                  !tranState.isError,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (tranState.isLoading &&
                                        index == tranState.chats.length - 1)
                                      ShowQuestion(
                                        question: tranState.query,
                                      ),
                                    if (tranState.isError &&
                                        index == tranState.chats.length - 1)
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
                if (tranState.isLoading && tranState.chats.isEmpty)
                  Expanded(
                    child: ShowQuestion(
                      question: tranState.query,
                    ),
                  ),
                if (tranState.isError && tranState.chats.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Error(),
                  ),
                if (tranState.isError && tranState.chats.isEmpty)
                  const Spacer(),
                const SizedBox(height: 5),
                SendQuery(
                  textEditingController: transactionTextEditingController,
                  onSend: () {
                    if (tranState.isLoading == false) {
                      ref
                          .watch(transactionProvider.notifier)
                          .getTransactionResponse(
                            transactionTextEditingController.text,
                          )
                          .then(
                            (value) => transactionTextEditingController.clear(),
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
              heading: 'transaction',
              examples: const [
                'Find most popular products sold in last month',
              ],
              onExampleTap: () {
                if (tranState.isLoading == false) {
                  transactionTextEditingController.text =
                      'Find most popular products sold in last month';
                }
              },
            ),
        ],
      ),
    );
  }
}
