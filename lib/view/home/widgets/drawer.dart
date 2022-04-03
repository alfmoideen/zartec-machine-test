import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/controller/userController.dart';
import 'package:zartek/view/login/login.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({
    Key? key,
    this.currentUser,
  }) : super(key: key);
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? currentUser;

  @override
  Widget build(BuildContext context) {
    print(Get.find<UserController>().isPhone.value);
    print(Get.find<UserController>().mobile.value);
    return Drawer(
      child: Obx(
        () => ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          image: Get.find<UserController>().isPhone.value
                              ? const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/firebaseLogo.webp'))
                              : DecorationImage(
                                  image: NetworkImage(
                                      currentUser!.photoUrl.toString())),
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Get.find<UserController>().isPhone.value
                        ? Text(
                            Get.find<UserController>().mobile.value,
                            style: largeFont(Colors.black),
                          )
                        : Text(
                            currentUser!.displayName.toString(),
                            style: largeFont(Colors.black),
                          ),
                    Get.find<UserController>().isPhone.value
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ID : ',
                                style: mediumFont(Colors.black),
                              ),
                              Text(
                                currentUser!.id.substring(0, 4),
                                style: mediumFont(Colors.black),
                              )
                            ],
                          )
                  ],
                ),
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.green,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () async {
                await _googleSignIn
                    .signOut()
                    .then((value) => Get.to(() => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
