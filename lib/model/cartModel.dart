class CartModel {
  String? name;
  double? price;
  double? calories;
  int? count;
  int? index;
  int? mainIndex;

  CartModel(this.count, this.mainIndex, this.index, this.calories, this.price,
      this.name);
}
