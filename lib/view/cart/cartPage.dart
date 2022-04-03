import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/controller/cartController.dart';
import 'package:zartek/controller/dataController.dart';
import 'package:zartek/view/cart/widget/cartListView.dart';
import 'package:zartek/view/home/home.dart';
import 'package:zartek/widgets/bouncing.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 15,
          ),
          onPressed: () {
            Navigator.pop(context);
            Get.find<DataController>().getData();
          },
        ),
        title: Text(
          'Order Summary',
          style: mediumFont(Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CartListView(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Center(
            child: Bouncing(
              onPress: (Get.find<CartController>().cartList.isNotEmpty)? () {
                Get.snackbar('Success', 'Order Placed Successfully...!',
                    snackPosition: SnackPosition.TOP,
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    boxShadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    snackStyle: SnackStyle.FLOATING);
                Get.find<CartController>().resetValues();
                Get.find<DataController>().resetValues();
                Get.to(() => HomePage());
              }:(){
                Get.snackbar('Warning', 'Cart is Empty...!',
                    snackPosition: SnackPosition.TOP,
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.red,
                    colorText: Colors.black,
                    boxShadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        offset:
                        const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    snackStyle: SnackStyle.FLOATING);
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.green[900]),
                child: Center(
                  child: Text(
                    'Place Order',
                    style: mediumFont(Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
