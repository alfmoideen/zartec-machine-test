import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/controller/cartController.dart';
import 'package:zartek/controller/dataController.dart';
import 'package:zartek/view/cart/cartPage.dart';
import 'package:zartek/view/home/widgets/categorySection.dart';
import 'package:zartek/view/home/widgets/drawer.dart';
import 'package:zartek/view/home/widgets/foodItemTile.dart';
import 'package:zartek/widgets/bouncing.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key,}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GoogleSignInAccount? currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void initState() {
    Get.find<DataController>().getData();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: Bouncing(
          onPress: () {
            _key.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: [
          Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                Bouncing(
                  onPress: () {
                    Get.to(() => const CartPage());
                  },
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 8,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          Get.find<CartController>().cartList.length.toString(),
                          style: verySmallFontW600(Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      drawer: NavDrawer(currentUser: currentUser),
      body: Obx(
        () => Get.find<DataController>().dataList.isEmpty
            ? Center(
                child: Image.asset(
                  'assets/images/load.gif',
                  height: 50,
                ),
              )
            : Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: Get.find<DataController>()
                            .dataList[0]
                            .tableMenuList
                            .length,
                        itemBuilder: (context, index) {
                          return CategorySection(
                            tableMenuList: Get.find<DataController>()
                                .dataList[0]
                                .tableMenuList[index],
                            index: index,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: Get.find<DataController>()
                            .dataList[0]
                            .tableMenuList[
                                Get.find<DataController>().mainIndex.value]
                            .categoryDishes
                            .length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              FoodItemTile(
                                categoryDish: Get.find<DataController>()
                                    .dataList[0]
                                    .tableMenuList[Get.find<DataController>()
                                        .mainIndex
                                        .value]
                                    .categoryDishes[index],
                                index: index,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey[300],
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
      ),
    );
  }
}
