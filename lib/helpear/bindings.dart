import 'package:get/get.dart';
import 'package:th_dkweb/Controller/home_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
