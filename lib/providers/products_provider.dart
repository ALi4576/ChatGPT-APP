import 'package:ai/main.dart';
import 'package:ai/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductProvider extends StateNotifier<ProductState> {
  ProductProvider(
    this.ref,
  ) : super(const ProductState._());

  final Ref ref;

  resetState() {
    state = const ProductState._();
  }

  Future<void> getProductResponse(String query) async {
    if (state.isLoading || query.isEmpty) return;
    state = state.copyWith(
      isLoading: true,
      query: query,
      isError: false,
    );
    try {
      final response = await apiClient.getProductResponse(query);
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

class ProductState extends Equatable {
  const ProductState._({
    this.chats = const [],
    this.query = "",
    this.isLoading = false,
    this.isError = false,
  });

  final List<Chat> chats;
  final String query;
  final bool isLoading;
  final bool isError;

  ProductState copyWith({
    List<Chat>? chats,
    String? query,
    bool? isLoading,
    bool? isError,
  }) {
    return ProductState._(
      chats: chats ?? this.chats,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
        chats,
        query,
        isLoading,
        isError,
      ];
}
