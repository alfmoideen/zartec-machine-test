import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/view/login/otpScreen.dart';
import 'package:zartek/widgets/bouncing.dart';

class PhoneNumberLogin extends StatelessWidget {
  PhoneNumberLogin({Key? key}) : super(key: key);
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 15,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/firebaseLogo.webp',
                  height: 180,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Phone Number',
                  style: mediumFont(Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    style: largeFont(Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Bouncing(
                  onPress: () {
                    if (phoneController.text.length != 10) {
                      Get.snackbar('Warning', 'Enter Correct Number...!',
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.red,
                          colorText: Colors.black,
                          boxShadows: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          snackStyle: SnackStyle.FLOATING);
                      return;
                    }
                    Get.to(() => OtpScreen(
                      phone: phoneController.text.toString(),
                    ));
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: mediumFont(Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
