import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weather_app/models/whether_model.dart';
import 'package:weather_app/services/weatherServices.dart';
import 'package:weather_app/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Weatherservices _weatherservices = Weatherservices();
  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;

  WhetherModel? _weather;
  void _getWeather() async {
  setState(() {
    _isLoading = true;
  });

  try {
    final weather = await _weatherservices.featchWeather(_controller.text);
    setState(() {
      _weather = weather;
      _isLoading = false;
    });
  } catch (error) {
    // This is the key part for debugging
    print('Error caught--------------------: $error');
    
    // You can also show the specific error message to the user if you want
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error in fetching the data')));
    
    setState(() {
      _isLoading = false;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                  _weather!.description.toLowerCase().contains('rain')
              ? LinearGradient(
                  colors: [Colors.grey, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weather != null &&
                    _weather!.description.toLowerCase().contains('clear')
              ? LinearGradient(
                  colors: [Colors.orangeAccent, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(
                  colors: [Colors.grey, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter Your City Name",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none
                    )
                  ),
                ),

                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: _getWeather,
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(209, 190, 194, 196),
                    foregroundColor: const Color.fromARGB(255, 65, 156, 231),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ) ),
                  child: Text(
                    "Get Weather",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  ),
                  if(_isLoading)
                  Padding(padding: EdgeInsets.all(20),child: CircularProgressIndicator(color: Colors.white,),),
                  if(_weather != null)
                  WeatherCard(weather: _weather!),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
