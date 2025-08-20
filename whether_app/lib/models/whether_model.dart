class WhetherModel {
  final String cityName;
  final double temparature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  WhetherModel({
    required this.cityName,
    required this.description,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.temparature,
    required this.windSpeed,
  });

  factory WhetherModel.fromJson(Map<String, dynamic> json) {
    return WhetherModel(
      cityName: json['name'],
      // Corrected: Access the 'description' from the first item in the 'weather' list
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      temparature: json['main']['temp'] - 273.15,
      windSpeed: json['wind']['speed'].toDouble(), // Good practice to be explicit
    );
  }
}