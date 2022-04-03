import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek/controller/userController.dart';
import 'package:zartek/view/home/home.dart';
import 'package:zartek/view/login/phoneNumberLogin.dart';
import 'package:zartek/view/login/widgets/googleButton.dart';
import 'package:zartek/view/login/widgets/mobileButton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/firebaseLogo.webp',
                  height: 180,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                ),
                GoogleButton(
                  onPress: () async {
                    await _googleSignIn.signIn().then((value) => {
                          if (value != null) {
                            Get.find<UserController>().isPhone.value=false,
                            Get.to(() => HomePage())}
                        });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MobileButton(
                  onPress: () {
                    Get.to(() => PhoneNumberLogin());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
