import 'package:get/get.dart';
import 'package:zartek/controller/cartController.dart';
import 'package:zartek/controller/dataController.dart';
import 'package:zartek/controller/userController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DataController());
    Get.put(CartController());
    Get.put(UserController());
  }
}
