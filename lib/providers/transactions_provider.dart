import 'package:ai/main.dart';
import 'package:ai/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionProvider extends StateNotifier<TransactionState> {
  TransactionProvider(
    this.ref,
  ) : super(const TransactionState._());

  final Ref ref;

  resetState() {
    state = const TransactionState._();
  }

  Future<void> getTransactionResponse(String query) async {
    if (state.isLoading || query.isEmpty) return;
    state = state.copyWith(
      isLoading: true,
      query: query,
      isError: false,
    );
    try {
      final response = await apiClient.getTransactionResponse(query);
      state = state.copyWith(
        isLoading: false,
        query: "",
        chats: [
          ...state.chats,
          response,
        ],
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        query: "",
        isError: true,
      );
    }
  }
}

class TransactionState extends Equatable {
  const TransactionState._({
    this.chats = const [],
    this.isLoading = false,
    this.query = "",
    this.isError = false,
  });

  final List<Chat> chats;
  final bool isLoading;
  final String query;
  final bool isError;

  TransactionState copyWith({
    List<Chat>? chats,
    bool? isLoading,
    String? query,
    bool? isError,
  }) {
    return TransactionState._(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      query: query ?? this.query,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
        chats,
        isLoading,
        query,
        isError,
      ];
}
