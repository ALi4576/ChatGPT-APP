import 'package:hooks_riverpod/hooks_riverpod.dart';

class TranslationProvider extends StateNotifier<String> {
  TranslationProvider(
    this.ref,
  ) : super('en');

  final Ref ref;

  void changeLanguage(String language) {
    state = language;
  }
}
