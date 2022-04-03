import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/controller/cartController.dart';
import 'package:zartek/controller/dataController.dart';
import 'package:zartek/widgets/bouncing.dart';

class CartItemTile extends StatelessWidget {
  CartItemTile({Key? key, this.data, this.index}) : super(key: key);
  Map<String, dynamic>? data;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            width: 35,
            child: Icon(Icons.radio_button_checked_outlined,
                color:
                    (data!['type'] == 2) ? Colors.green[900] : Colors.red[900]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 100,
                  child: Text(
                    data!['name'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: mediumFont(Colors.black),
                  )),
              Text(
                'INR ${data!['price'].toString()}',
                style: smallFontW600(Colors.grey),
              ),
              Text(
                '${data!['calories'].toString()} calories',
                style: smallFontW600(Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 35,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: const BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Bouncing(
                      onPress: () {
                        Get.find<DataController>().countSub(
                            data!['index'],
                            data!['name'].toString(),
                            data!['price'],
                            data!['calories'],
                            data!['type']);
                        (context as Element).reassemble();
                      },
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 20,
                      )),
                  Obx(
                    () => Text(
                      Get.find<DataController>()
                          .itemCountList[data!['mainIndex']][data!['index']]
                          .toString(),
                      style: mediumFont(Colors.white),
                    ),
                  ),
                  Bouncing(
                    onPress: () {
                      Get.find<DataController>().countAdd(
                          data!['index'],
                          data!['name'].toString(),
                          data!['price'],
                          data!['calories'],
                          data!['type']);
                      (context as Element).reassemble();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          Text(
            'INR ${Get.find<CartController>().amountList[data!['mainIndex']][data!['index']].toString()}',
            style: mediumFont(Colors.black),
          )
        ],
      ),
    );
  }
}
