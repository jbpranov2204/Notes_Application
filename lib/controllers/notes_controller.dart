import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/note.dart';

class NotesController extends GetxController {
  final notes = <Note>[].obs;
  final filteredNotes = <Note>[].obs;
  final selectedNote = Rx<Note?>(null);
  final searchQuery = ''.obs;
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    addNote('Welcome to Notes', 'Start writing your thoughts here...');
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  void addNote(String title, String content) {
    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    notes.add(note);
    // Print note details to console
    print('New Note Created:');
    print('Title: ${note.title}');
    print('Content: ${note.content}');
    print('Created at: ${note.createdAt}');
    print('-' * 50);
    clearForm();
  }

  void updateNote(String id, String title, String content) {
    final index = notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      notes[index] = notes[index].copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
      );
    }
    clearForm();
  }

  void deleteNote(String id) {
    notes.removeWhere((note) => note.id == id);
  }

  void restoreNote(Note note) {
    notes.add(note);
    if (searchQuery.isNotEmpty) {
      searchNotes(searchQuery.value);
    }
    notes.refresh();
  }

  Note? getNoteById(String id) {
    final note = notes.firstWhereOrNull((note) => note.id == id);
    if (note != null) {
      titleController.text = note.title;
      contentController.text = note.content;
      selectedNote.value = note;
    }
    return note;
  }

  void searchNotes(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredNotes.value = notes;
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    filteredNotes.value =
        notes.where((note) {
          return note.title.toLowerCase().contains(lowercaseQuery) ||
              note.content.toLowerCase().contains(lowercaseQuery);
        }).toList();
  }

  void sortNotes(String criteria) {
    switch (criteria) {
      case 'title':
        notes.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case 'date':
        notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
    }
    searchNotes(searchQuery.value);
  }

  void clearForm() {
    titleController.clear();
    contentController.clear();
    selectedNote.value = null;
  }
}
