import 'package:flutter/cupertino.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/use_case/use_cases.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/presentation/notes/notes_event.dart';

import 'notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases _useCases;

  NotesState _state = NotesState();

  NotesState get state => _state;

  Note? recentelyDeltedNote;

  NotesViewModel(this._useCases) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreEvent: _restoreNote,
      changeOrder: _changeOrder,
      toggleOrderSection: _toggleOrderSection,
    );
  }

  void _toggleOrderSection() {
    _state =
        _state.copyWith(isOrderSectionVisible: !_state.isOrderSectionVisible);
    notifyListeners();
  }

  void _changeOrder(NoteOrder noteOrder) {
    _state = _state.copyWith(noteOrder: noteOrder);
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await _useCases.getNotes(state.noteOrder);

    _state = state.copyWith(notes: notes);

    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await _useCases.deleteNote(note);

    recentelyDeltedNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (recentelyDeltedNote != null) {
      await _useCases.addNote(recentelyDeltedNote!);
    }

    recentelyDeltedNote = null;

    await _loadNotes();
  }
}
