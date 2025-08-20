import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:whether_app/models/whether_model.dart';

class WeatherCard extends StatelessWidget {
  final WhetherModel weather;
  const WeatherCard({super.key,required this.weather});

String formatTime(int timestampInSeconds) {
  // Convert the timestamp from seconds to milliseconds
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);

  // Format the DateTime object into a human-readable string (e.g., 05:30 PM)
  final formatter = DateFormat('h:mm a'); // h:mm a for 12-hour format with AM/PM
  return formatter.format(dateTime);
}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration:  BoxDecoration(
            color: Color.fromARGB(113,255,255,255),
          borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset(
                weather.description.contains('rain')
                    ? "assets/rain.json"
                    : weather.description.contains("clear")
                    ? 'assets/sunny.json'
                    : 'assets/cloudy.json',
                height: 150,
                width: 150,
              ),
              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              SizedBox(height: 10),
              Text(
                '${weather.temparature.toStringAsFixed(1)}°C',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                weather.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Humidity: ${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Wind: ${weather.windSpeed}ms',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                      Text(
                        'SunRise',style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(formatTime(weather.sunrise),
                      
                      style: Theme.of(context).textTheme.bodyMedium
                      ,)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.nights_stay_outlined, color: Colors.purple),
                      Text(
                        'SunSet',style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(formatTime(weather.sunset),
                      style: Theme.of(context).textTheme.bodyMedium
                      ,)
                    ],
                  ),
                 
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
