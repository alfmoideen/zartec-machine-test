import 'package:flutter/material.dart';
import 'package:zartek/widgets/bouncing.dart';

class MobileButton extends StatelessWidget {
  MobileButton({Key? key, this.onPress}) : super(key: key);
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
            color: Colors.green),
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
                      color: Colors.green),
                  child: const Center(
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                )),
            const Center(
              child: Text(
                'Phone',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
