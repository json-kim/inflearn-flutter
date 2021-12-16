import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search/model/photo.dart';

class PixabayApi {
  final baseUrl = 'https://pixabay.com/api/';
  final apiKey = '24806114-c007510d8db60c6c4666be055';

  Future<List<Photo>> fetchPhotos(String query) async {
    final response = await http
        .get(Uri.parse('$baseUrl?key=$apiKey&q=$query&image_type=photo'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    // jsonResponse['hits']를 캐스팅해주는 과정이 필요하다
    // dynamic에 메서드를 호출시 하얀색 물결 밑줄이 생긴다.
    // 따라서 중간에 jsonResponse['hits']를 형변환 해주지 않는다면,
    // map의 결과는 Iterable<dynamic>, toList의 결과는 List<dynamic>이 된다.
    final photos = (jsonResponse['hits'] as List<dynamic>)
        .map((json) => Photo.fromJson(json))
        .toList();
    return photos;
  }
}
