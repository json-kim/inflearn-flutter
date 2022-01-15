import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/domain/use_case/get_notes_use_case.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/domain/util/order_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notes_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  test('정렬 기능을 테스트합니다.', () async {
    final repository = MockNoteRepository();
    final useCase = GetNotesUseCase(repository);

    // 동작을 정의
    when(repository.getNotes()).thenAnswer((_) async => [
          Note(title: 'title', content: 'content', timestamp: 1, color: 1),
          Note(title: 'title2', content: 'content2', timestamp: 2, color: 2),
        ]);

    List<Note> result = await useCase(NoteOrder.title(OrderType.ascending()));

    // 타입 검사
    expect(result, isA<List<Note>>());
    expect(result.first.timestamp, 2);
    verify(repository.getNotes());

    result = await useCase(NoteOrder.title(OrderType.descending()));
    expect(result.first.timestamp, 1);
  });
}
