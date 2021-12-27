import 'package:flutter_test/flutter_test.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';
import 'package:image_search/presentation/home/home_view_model.dart';

void main() {
  test('Stream이 잘 동작해야 한다.', () async {
    final viewModel = HomeViewModel(repository: FakePhotoApiRepository());

    await viewModel.fetch('apple');

    final result = fakeJson.map((e) => Photo.fromJson(e)).toList();

    expect(viewModel.photos, result);
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<List<Photo>> fetch(String query) async {
    Future.delayed(const Duration(milliseconds: 300));

    return fakeJson.map((e) => Photo.fromJson(e)).toList();
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 620817,
    "pageURL":
        "https://pixabay.com/photos/office-notes-notepad-entrepreneur-620817/",
    "type": "photo",
    "tags": "office, notes, notepad",
    "previewURL":
        "https://cdn.pixabay.com/photo/2015/02/02/11/08/office-620817_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g4879a9edcc998064e0d434f65fb9936c42d70fbe1b3fd4c15adf9241296669e160ffb8879bfb45053167a549bfd1d88c_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 425,
    "largeImageURL":
        "https://pixabay.com/get/g8708d91fe67aa85bf95183a38762f102352d775ce5e6f597dafe2c1996666571897e71f467ed263734d980dd72f7146e6a610171aef40f621e4531b199fef5bc_1280.jpg",
    "imageWidth": 4288,
    "imageHeight": 2848,
    "imageSize": 2800224,
    "views": 640324,
    "downloads": 273672,
    "collections": 3496,
    "likes": 1071,
    "comments": 244,
    "user_id": 663163,
    "user": "Firmbee",
    "userImageURL":
        "https://cdn.pixabay.com/user/2020/11/25/09-38-28-431_250x250.png"
  },
  {
    "id": 410311,
    "pageURL":
        "https://pixabay.com/photos/iphone-hand-screen-smartphone-apps-410311/",
    "type": "photo",
    "tags": "iphone, hand, screen",
    "previewURL":
        "https://cdn.pixabay.com/photo/2014/08/05/10/27/iphone-410311_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/gdc819c51d49752a83cedcd041c92fb6d756de7a78202a7478709bea6990f9f208905ccf6bc27688656e599b465dcea94_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/gb4aba11613867e8ca36482e2fe1dbf5fba361963b6b28f2380b984363ede53b9893e3ec693adf8b459569cbde30ce0aa3b6d09bab53683b208034ba0006a4a8b_1280.jpg",
    "imageWidth": 1920,
    "imageHeight": 1280,
    "imageSize": 416413,
    "views": 449348,
    "downloads": 218327,
    "collections": 3331,
    "likes": 579,
    "comments": 147,
    "user_id": 264599,
    "user": "JESHOOTS-com",
    "userImageURL":
        "https://cdn.pixabay.com/user/2014/06/08/15-27-10-248_250x250.jpg"
  },
];
