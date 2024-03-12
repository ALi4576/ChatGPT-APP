import 'dart:convert';

import 'package:ai/api/api_urls.dart';
import 'package:ai/model/model.dart';
import 'package:ai/utils/utils.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient() {
    baseUrl = getUrl();
  }

  String baseUrl = '';

  Future<Chat> getProductResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + productUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "query": query,
          },
        ),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final res = responseFromJson(utf8.decode(response.bodyBytes));
        return Chat(
          question: query,
          answer: res.response,
          createdAt: DateTime.now(),
        );
      } else {
        throw Exception('Failed to generate response');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Chat> getTransactionResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + transactionUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"query": query},
        ),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final res = responseFromJson(utf8.decode(response.bodyBytes));
        return Chat(
          question: query,
          answer: res.response,
          createdAt: DateTime.now(),
        );
      } else {
        throw Exception('Failed to generate response');
      }
    } catch (e) {
      rethrow;
    }
  }
}
