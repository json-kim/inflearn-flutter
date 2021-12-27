import 'dart:convert';

import 'package:http/http.dart' as http;

class PixabayApi {
  static const baseUrl = 'https://pixabay.com/api/';
  static const apiKey = '24806114-c007510d8db60c6c4666be055';

  final http.Client client;

  PixabayApi(this.client);

  Future<List<dynamic>> fetch(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl?key=$apiKey&q=$query&image_type=photo'));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List hits = jsonResponse['hits'];
    return hits;
  }
}
