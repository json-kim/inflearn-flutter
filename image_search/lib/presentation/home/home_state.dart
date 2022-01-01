import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_search/domain/model/photo.dart';

part 'home_state.freezed.dart';

// class HomeState {
//   final List<Photo> photos;
//   final bool isLoading;
//
//   HomeState(this.photos, this.isLoading);
//
//   HomeState copyWith({List<Photo>? photos, bool? isLoading}) {
//     return HomeState(
//       photos ??= this.photos,
//       isLoading ??= this.isLoading,
//     );
//   }
// }

@freezed
class HomeState with _$HomeState {
  factory HomeState(
    List<Photo> photos,
    bool isLoading,
  ) = _HomeState;
}
