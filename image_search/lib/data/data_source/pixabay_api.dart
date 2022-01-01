import 'dart:convert';

import 'package:http/http.dart' as http;

import 'result.dart';

class PixabayApi {
  static const baseUrl = 'https://pixabay.com/api/';
  static const apiKey = '24806114-c007510d8db60c6c4666be055';

  final http.Client client;

  PixabayApi(this.client);

  Future<Result<List>> fetch(String query) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl?key=$apiKey&q=$query&image_type=photo'));
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List hits = jsonResponse['hits'];
      return Result.success(hits);
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }
}
