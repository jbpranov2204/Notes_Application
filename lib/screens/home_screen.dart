import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/notes_controller.dart';
import '../controllers/theme_controller.dart';
import '../models/note.dart';

class HomeScreen extends GetView<NotesController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.background.withBlue(
              Theme.of(context).colorScheme.background.blue + 15,
            ),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Notes',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Obx(
                () => Text(
                  '${controller.notes.length} notes',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Obx(
              () => IconButton(
                icon: Icon(
                  themeController.isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  size: 28,
                ),
                onPressed: themeController.toggleTheme,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, size: 28),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: controller.searchNotes,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Search notes...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.sort, size: 28),
              onSelected: controller.sortNotes,
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(
                      value: 'title',
                      child: Row(
                        children: [
                          Icon(Icons.sort_by_alpha),
                          SizedBox(width: 12),
                          Text('Sort by Title'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'date',
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 12),
                          Text('Sort by Date'),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.background.withBlue(
                  Theme.of(context).colorScheme.background.blue + 15,
                ),
              ],
            ),
          ),
          child: Obx(() {
            final displayNotes =
                controller.searchQuery.isEmpty
                    ? controller.notes
                    : controller.filteredNotes;

            if (displayNotes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.searchQuery.isEmpty
                          ? 'No notes yet\nTap + to create one'
                          : 'No matching notes found',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 8, bottom: 88),
              itemCount: displayNotes.length,
              itemBuilder: (context, index) {
                final note = displayNotes[index];
                return _buildNoteCard(context, note);
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed('/note/new'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, Note note) {
    return Dismissible(
      key: Key(note.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.delete, color: Colors.red.shade700),
      ),
      confirmDismiss: (direction) async {
        final result = await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Delete Note?'),
            content: const Text('Are you sure you want to delete this note?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );

        if (result == true) {
          await controller.deleteNote(note.id);
          Get.showSnackbar(
            GetSnackBar(
              message: 'Note deleted',
              mainButton: TextButton(
                onPressed: () async {
                  await controller.addNote(note.title, note.content);
                  Get.closeCurrentSnackbar();
                },
                child: const Text(
                  'UNDO',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
        return false;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Material(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () => Get.toNamed('/note/${note.id}'),
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.black,
            highlightColor: Colors.black,
            child: Theme(
              data: ThemeData.light(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      note.content,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.edit_calendar,
                              size: 14,
                              color: const Color(0xFF757575),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Created: ${DateFormat('MMM dd, yyyy').format(note.createdAt)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.update,
                              size: 14,
                              color: const Color(0xFF757575),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Updated: ${DateFormat('MMM dd, yyyy').format(note.updatedAt)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
