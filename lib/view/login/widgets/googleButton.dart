import 'package:flutter/material.dart';
import 'package:zartek/widgets/bouncing.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({Key? key,this.onPress}) : super(key: key);
  VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPress: onPress,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.blue),
        child: Stack(
          children: [
            Positioned(
                left: 15,
                top: 15,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white),
                  child: Center(
                    child: Image.asset(
                      'assets/images/googleLogo.png',
                      height: 20,
                    ),
                  ),
                )),
            const Center(
              child: Text(
                'Google',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
