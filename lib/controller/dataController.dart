import 'dart:collection';

import 'package:get/get.dart';
import 'package:zartek/apiService/dataApi.dart';
import 'package:zartek/controller/cartController.dart';

class DataController extends GetxController {
  var dataList = [].obs;
  var categoryIndexList = [].obs;
  var mainIndex = 0.obs;
  var checkCart = false.obs;
  var itemCountList = [
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0],
    [0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ].obs;

  Future getData() async {
    print("call started");
    if (dataList.isNotEmpty) {
      dataList.clear();
      categoryIndexList.clear();
      update();
    }
    final response = await DataApi().getData();
    if (response != null) {
      dataList.value = response.toList();
      update();
      dataList[0].tableMenuList.forEach((element) {
        categoryIndexList.add(false);
        update();
      });
      categoryIndexList[0] = true;
      mainIndex.value = 0;
      update();
    }
  }

  changeIndex(int index) {
    categoryIndexList.asMap().forEach((i, value) {
      if (index == i) {
        categoryIndexList[i] = true;
        mainIndex.value = i;
        update();
      } else {
        categoryIndexList[i] = false;
        update();
      }
    });
  }

  countAdd(int index, String name, double price, double calories,int type) {
    itemCountList[mainIndex.value][index] =
        itemCountList[mainIndex.value][index] + 1;
    update();
    Map<String, dynamic> body = {
      'name': name,
      'price': price,
      'calories': calories,
      'count': itemCountList[mainIndex.value][index],
      'index': index,
      'mainIndex': mainIndex.value,
      'type':type
    };
    // Get.find<CartController>().cartList.clear();
    // update();
    if (Get.find<CartController>().cartList.isNotEmpty) {
      Get.find<CartController>().cartList.asMap().forEach((key, value) {
        {
          if (value['name'].toString().contains(name)) {
            checkCart.value = false;
            Get.find<CartController>().cartList[key] = body;
            update();
            Get.find<CartController>().changeAmount(index, mainIndex.value,
                itemCountList[mainIndex.value][index], price);
          } else {
            checkCart.value = true;
            update();
          }
        }
      });
      if (checkCart.value) {
        Get.find<CartController>().cartList.add(body);
        Get.find<CartController>().cartList.value =
            LinkedHashSet<dynamic>.from(Get.find<CartController>().cartList)
                .toList();
        update();
        Get.find<CartController>().changeAmount(index, mainIndex.value,
            itemCountList[mainIndex.value][index], price);
      }
    } else {
      Get.find<CartController>().cartList.add(body);
      update();
      Get.find<CartController>().changeAmount(
          index, mainIndex.value, itemCountList[mainIndex.value][index], price);
    }
    print(Get.find<CartController>().cartList);
  }

  countSub(int index, String name, double price, double calories,int type) {
    int? val;
    if (itemCountList[mainIndex.value][index] != 0) {
      itemCountList[mainIndex.value][index] =
          itemCountList[mainIndex.value][index] - 1;
      checkCart.value = false;
      update();
      Map<String, dynamic> body = {
        'name': name,
        'price': price,
        'calories': calories,
        'count': itemCountList[mainIndex.value][index],
        'index': index,
        'mainIndex': mainIndex.value,
        'type':type
      };
      if (Get.find<CartController>().cartList.isNotEmpty) {
        Get.find<CartController>().cartList.asMap().forEach((key, value) {
          if (value['name'].toString().contains(name)) {
            checkCart.value = false;
            if (itemCountList[mainIndex.value][index] != 0) {
              Get.find<CartController>().cartList[key] = body;
              update();
              Get.find<CartController>().changeAmount(index, mainIndex.value,
                  itemCountList[mainIndex.value][index], price);
            } else {
              val = key;
              checkCart.value = true;
              update();
            }
          }
        });
        if (checkCart.value) {
          Get.find<CartController>().cartList.removeAt(val!);
          update();
          Get.find<CartController>().changeAmount(index, mainIndex.value,
              itemCountList[mainIndex.value][index], price);
        }
      }
    }
    print(Get.find<CartController>().cartList);
  }

  resetValues() {
    dataList.clear();
    categoryIndexList.clear();
    mainIndex.value = 0;
    checkCart.value = false;
    itemCountList.value = [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0],
      [0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];
  }
}
