import 'package:get/get.dart';
import '../controllers/notes_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotesController());
  }
}
