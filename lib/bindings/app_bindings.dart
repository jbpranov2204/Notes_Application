import 'package:get/get.dart';
import '../controllers/notes_controller.dart';
import '../controllers/theme_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NotesController());
    Get.put(ThemeController());
  }
}
