import 'package:flutter_test/flutter_test.dart';
import 'package:resto_app/data/model/restaurant_list.dart';

var testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};
void main() {
  test("Test Parsing", () async {
    var result = Restaurantlist.fromJson(testRestaurant).id;

    expect(result, "rqdv5juczeskfw1e867");
  });
}