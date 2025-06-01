import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/notes_controller.dart';

class EditNoteScreen extends GetView<NotesController> {
  final bool isNewNote;

  EditNoteScreen({Key? key, this.isNewNote = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          isNewNote ? 'New Note' : 'Edit Note',
          style: TextStyle(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Created: ${DateFormat('MMM dd, yyyy HH:mm').format(DateTime.now())}',
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.black54,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Updated: ${DateFormat('MMM dd, yyyy HH:mm').format(DateTime.now())}',
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(child: Text('Edit Note Screen')),
          ],
        ),
      ),
    );
  }
}
