import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/controller/dataController.dart';
import 'package:zartek/model/foodModel.dart';

class CategorySection extends StatelessWidget {
  CategorySection({Key? key, this.tableMenuList, this.index}) : super(key: key);
  TableMenuList? tableMenuList;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          Get.find<DataController>().changeIndex(index!);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Get.find<DataController>().categoryIndexList[index!]
                  ? const Border(bottom: BorderSide(color: Colors.red,width: 3))
                  : null),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Text(
              tableMenuList!.menuCategory.toString(),
              style: Get.find<DataController>().categoryIndexList[index!]
                  ? mediumFont(Colors.red)
                  : mediumFont(Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
