import 'package:image_search/data/data_source/pixabay_api.dart';
import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';

class PhotoApiRepositoryImpl implements PhotoApiRepository {
  final PixabayApi api;

  PhotoApiRepositoryImpl(this.api);

  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    final Result<List> result = await api.fetch(query);

    return result.when(
      success: (list) {
        final photos = list.map((json) => Photo.fromJson(json)).toList();
        return Result.success(photos);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
