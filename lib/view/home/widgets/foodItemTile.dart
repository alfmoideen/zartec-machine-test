import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek/constants/fonts.dart';
import 'package:zartek/controller/dataController.dart';
import 'package:zartek/model/foodModel.dart';
import 'package:zartek/widgets/bouncing.dart';

class FoodItemTile extends StatefulWidget {
  FoodItemTile({Key? key, this.categoryDish, this.index}) : super(key: key);
  CategoryDish? categoryDish;
  int? index;

  @override
  State<FoodItemTile> createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> {
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
                color: (widget.categoryDish!.dishType == 2)
                    ? Colors.green[900]
                    : Colors.red[900]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 200,
                  child: Text(
                    widget.categoryDish!.dishName.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: largeFont(Colors.black),
                  )),
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'INR ',
                          style: mediumFont(Colors.black),
                        ),
                        Text(widget.categoryDish!.dishPrice.toString(),
                            style: mediumFont(Colors.black))
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.categoryDish!.dishCalories.toString(),
                            style: mediumFont(Colors.black)),
                        Text(' calories', style: mediumFont(Colors.black))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: 200,
                  child: Text(
                    widget.categoryDish!.dishDescription.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: smallFontW600(Colors.grey),
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 35,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Bouncing(
                          onPress: () {
                            Get.find<DataController>().countSub(
                                widget.index!,
                                widget.categoryDish!.dishName.toString(),
                                widget.categoryDish!.dishPrice!,
                                widget.categoryDish!.dishCalories!,
                                widget.categoryDish!.dishType!);
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
                              .itemCountList[Get.find<DataController>()
                                  .mainIndex
                                  .value][widget.index!]
                              .toString(),
                          style: mediumFont(Colors.white),
                        ),
                      ),
                      Bouncing(
                        onPress: () {
                          Get.find<DataController>().countAdd(
                              widget.index!,
                              widget.categoryDish!.dishName.toString(),
                              widget.categoryDish!.dishPrice!,
                              widget.categoryDish!.dishCalories!,
                              widget.categoryDish!.dishType!);
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
              widget.categoryDish!.addonCat!.isNotEmpty
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox(),
              widget.categoryDish!.addonCat!.isNotEmpty
                  ? Text(
                      'Customizations Available',
                      style: largeFont(Colors.red),
                    )
                  : const SizedBox()
            ],
          ),
          const Spacer(),
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        NetworkImage(widget.categoryDish!.dishImage.toString()),
                    fit: BoxFit.contain),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey)),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
