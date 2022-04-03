import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/controller/cartController.dart';
import 'package:zartek/view/cart/widget/cartItemTile.dart';

class CartListView extends StatelessWidget {
  const CartListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Obx(
                () => Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.green[900],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      '${Get.find<CartController>().cartList.length} Dishes - ${Get.find<CartController>().totalQuantity} Items',
                      style: mediumFont(Colors.white),
                    ),
                  ),
                ),
              ),
              Obx(
                () => ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Get.find<CartController>().cartList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CartItemTile(
                            data: Get.find<CartController>().cartList[index],
                            index: index,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey[300],
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: largeFont(Colors.black),
                  ),
                  Obx(
                    () => Text(
                      'INR ' +
                          Get.find<CartController>().totalAmount.toString(),
                      style: largeFont(Colors.black),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
