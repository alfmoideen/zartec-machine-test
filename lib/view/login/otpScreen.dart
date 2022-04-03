import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/controller/userController.dart';
import 'package:zartek/view/home/home.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, this.phone}) : super(key: key);
  String? phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;

  // final TextEditingController _pinPutController = TextEditingController();
  // final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter the OTP which send to ',
                      style: smallFont(Colors.grey),
                    ),
                    Text(
                      widget.phone!,
                      style: mediumFont(Colors.black),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: PinCodeTextField(
                      appContext: context,
                      textStyle: const TextStyle(color: Colors.black),
                      length: 6,
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.done,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      enablePinAutofill: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        // fieldHeight: 50,
                        // fieldWidth: 50,
                        activeFillColor: Colors.grey[400],
                        inactiveFillColor: Colors.grey[400],
                        activeColor: Colors.grey[400],
                        inactiveColor: Colors.grey[400],
                        selectedColor: Colors.grey[400],
                        selectedFillColor: Colors.grey[400],
                      ),
                      onChanged: (value) {},
                      onCompleted: (pin) async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode!,
                                      smsCode: pin))
                              .then((value) async {
                            if (value.user != null) {
                              Get.find<UserController>().isPhone.value = true;
                              Get.find<UserController>().mobile.value =
                                  widget.phone!;
                              Get.to(() => HomePage());
                            }
                          });
                        } catch (e) {
                          FocusScope.of(context).unfocus();
                          Get.snackbar('Warning', 'Invalid OTP...!',
                              snackPosition: SnackPosition.TOP,
                              duration: const Duration(seconds: 1),
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
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Get.find<UserController>().isPhone.value = true;
              Get.find<UserController>().mobile.value = widget.phone!;
              Get.to(() => HomePage());
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }
}
