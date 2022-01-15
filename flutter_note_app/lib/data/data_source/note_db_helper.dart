import 'package:flutter_note_app/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDbHelper {
  Database db;

  NoteDbHelper(this.db);

  Future<Note?> getNoteById(int id) async {
    // SELECT * FROM note WHERE id = 1
    final List<Map<String, dynamic>> maps = await db.query(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }

    return null;
  }

  Future<List<Note>> getNotes() async {
    final List<Map<String, dynamic>> maps = await db.query('note');

    return maps.map((e) => Note.fromJson(e)).toList();
  }

  Future<int> insertNote(Note note) async {
    return await db.insert('note', note.toJson());
  }

  Future<int> updateNote(Note note) async {
    return await db.update(
      'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(Note note) async {
    return await db.delete('note', where: 'id = ?', whereArgs: [note.id]);
  }
}
