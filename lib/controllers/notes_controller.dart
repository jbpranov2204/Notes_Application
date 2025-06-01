import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/note.dart';
import '../Helpers/database_helper.dart';

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
    loadNotes();
  }

  Future<void> loadNotes() async {
    final allNotes = await NotesDatabase.instance.readAllNotes();
    notes.value = allNotes;
    if (notes.isEmpty) {
      await addNote('Welcome to Notes', 'Start writing your thoughts here...');
    }
  }

  Future<void> addNote(String title, String content) async {
    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await NotesDatabase.instance.createNote(note);
    await loadNotes();
    clearForm();
  }

  Future<void> updateNote(String id, String title, String content) async {
    final note = await NotesDatabase.instance.readNote(id);
    if (note != null) {
      final updatedNote = note.copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
      );
      await NotesDatabase.instance.updateNote(updatedNote);
      await loadNotes();
    }
    clearForm();
  }

  Future<void> deleteNote(String id) async {
    await NotesDatabase.instance.deleteNote(id);
    await loadNotes();
  }

  Future<Note?> getNoteById(String id) async {
    final note = await NotesDatabase.instance.readNote(id);
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
