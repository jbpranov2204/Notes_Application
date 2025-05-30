import 'package:get/get.dart';
import '../screens/home_screen.dart';
import '../screens/note_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/note/new', page: () => const NoteScreen()),
    GetPage(name: '/note/:id', page: () => const NoteScreen()),
  ];
}
