import 'package:flutter/material.dart';
import 'package:api_clima/class/city_weather.dart';
import 'package:api_clima/helpers/get_weather.dart';
import 'package:api_clima/widgets/tarjeta.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  String city = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0D47A1),
        appBar: AppBar(
          title: const Text('Weather App'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Column(
          children: [
            Container(
              margin:const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: TextField(
                controller: controller,
                style:const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  
                  

                  

                  ),
                onSubmitted: (value) {
                  city = controller.text;
                  setState(() {});
                  controller.clear();
                },
              ),
            ),
            const SizedBox(height: 15),
            futureBuilder(city),
          ],
        )));
  }
}

Widget futureBuilder(String value) {
  if (value.isEmpty) {
    return Column(
      children: const [
        SizedBox(height: 20),
        Text(
          'No se realizo ninguna busqueda',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  } else {
    return FutureBuilder<CityWeather>(
      future: getWeather(value),
      builder: (BuildContext context, AsyncSnapshot<CityWeather> snapshot) {
        if (snapshot.hasData) {
          CityWeather city = snapshot.data!;
          return Tarjeta(
            city: city.name!,
            temp: '${city.main!.temp}',
            countryCode: city.sys!.country!,
            icon: city.weather!.first.icon!,
            description: city.weather!.first.description!,
          );
        } else if (snapshot.hasError) {
          return const Text('snapshot.hasError');
        } else {
          return Column(
            children: const [
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          );
        }
      },
    );
  }
}
