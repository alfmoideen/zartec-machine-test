import 'package:get/get.dart';
import 'package:zartek/controller/dataController.dart';

class CartController extends GetxController {
  var cartList = [].obs;
  var amountList = [
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0],
    [0.0, 0.0],
    [0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0]
  ].obs;
  var totalAmount = 0.0.obs;
  var totalQuantity = 0.obs;

  changeAmount(int index, int mainIndex, int count, double price) {
    totalAmount.value = 0.0;
    totalQuantity.value = 0;
    update();
    var amount = count * price;
    amountList[mainIndex][index] = amount;
    update();
    amountList.forEach((element) {
      element.forEach((value) {
        totalAmount.value = totalAmount.value + value;
      });
    });
    Get.find<DataController>().itemCountList.forEach((element) {
      element.forEach((value) {
        totalQuantity.value = totalQuantity.value + value;
        update();
      });
    });
    print(totalAmount);
    print(totalQuantity);
  }

  resetValues() {
    cartList.clear();
    amountList.value = [
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0],
      [0.0, 0.0],
      [0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0]
    ];
    totalAmount.value = 0.0;
    totalQuantity.value = 0;
    update();
  }
}
