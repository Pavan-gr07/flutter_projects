import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/whether_model.dart';

class Weatherservices {
  final String apiKey = '4dfa71d4a0129d1bf66cb38d5bc55812';

  Future<WhetherModel> featchWeather(String cityName) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${apiKey}",
    );

    final response = await http.get(url);

    // This is the new, more detailed print statement
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return WhetherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data with status code: ${response.statusCode}');
    }
  }
}