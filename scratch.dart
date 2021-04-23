import 'dart:async';
import 'package:http/http.dart';

main() async {
  var url = Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=5846bc25d8d21d9b398fce7cdac62ec3");

  Response response = await get(url);

  print('$url\n');
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.statusCode);
  }
}
