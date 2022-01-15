import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/ui/colors.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  StreamSubscription? _subscription;

  final List<Color> colors = [roseBud, primRose, wisteria, skyBlue, illusion];

  @override
  void initState() {
    _titleController.text = widget.note?.title ?? '';
    _contentController.text = widget.note?.content ?? '';
    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();
      _subscription = viewModel.eventStream.listen((event) {
        event.when(saveNote: () {
          Navigator.pop(context, true);
        }, showSnackBar: (message) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.onEvent(AddEditNoteEvent.saveNote(
            widget.note?.id,
            _titleController.text,
            _contentController.text,
          ));
        },
        child: const Icon(Icons.save),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: Color(viewModel.color),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: colors
                      .map((color) => InkWell(
                          onTap: () {
                            viewModel.onEvent(
                                AddEditNoteEvent.changeColor(color.value));
                          },
                          child: _buildBackgroundColor(
                              color: color,
                              selected: color.value == viewModel.color
                                  ? true
                                  : false)))
                      .toList(),
                ),
                TextField(
                  controller: _titleController,
                  cursorColor: darkGray,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: '제목을 입력하세요.',
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: darkGray),
                ),
                TextField(
                  controller: _contentController,
                  cursorColor: darkGray,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: '내용을 입력하세요.',
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: darkGray),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundColor({required Color color, required bool selected}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selected ? Border.all(width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 4,
            )
          ]),
    );
  }
}
