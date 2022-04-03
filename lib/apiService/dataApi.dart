import 'package:http/http.dart' as http;
import 'package:zartek/model/foodModel.dart';

class DataApi {
  Future getData() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad'),
      );
      if (response.statusCode == 200) {
        var json = response.body;
        print(json);
        return foodModelFromJson(json);
      } else {
        return null;
      }
    }
    catch (e) {
      print(e);
      return null;
    }
  }
}