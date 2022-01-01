import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';

class GetPhotosUseCase {
  final PhotoApiRepository repository;

  GetPhotosUseCase({required this.repository});

  // call 은 생략 가능!!
  Future<Result<List<Photo>>> call(String query) async {
    final result = await repository.fetch(query);

    return result.when(success: (photos) {
      return Result.success(photos.take(3).toList());
    }, error: (message) {
      return Result.error(message);
    });
  }
}
