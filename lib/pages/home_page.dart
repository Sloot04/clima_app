import 'package:api_clima/class/city_forecast.dart';
import 'package:api_clima/widgets/forecast_card.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

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
  List<Tarjeta> cityForecast = [
    const Tarjeta(
        city: 'Paraná',
        temp: '18',
        countryCode: 'AR',
        icon: '10d',
        description: 'Scattered clouds',
        width: 130,
        height: 200,
        country: false),
    const Tarjeta(
        city: 'Paraná',
        temp: '19',
        countryCode: 'AR',
        icon: '10d',
        description: 'Scattered clouds',
        width: 130,
        height: 200,
        country: false),
    const Tarjeta(
        city: 'Paraná',
        temp: '17',
        countryCode: 'AR',
        icon: '10d',
        description: 'Scattered clouds',
        width: 130,
        height: 200,
        country: false),
    const Tarjeta(
        city: 'Paraná',
        temp: '16',
        countryCode: 'AR',
        icon: '10d',
        description: 'Scattered clouds',
        width: 130,
        height: 200,
        country: false),
    const Tarjeta(
        city: 'Paraná',
        temp: '20',
        countryCode: 'AR',
        icon: '10d',
        description: 'Scattered clouds',
        width: 130,
        height: 200,
        country: false),
    const Tarjeta(
        city: 'Paraná',
        temp: '21',
        countryCode: 'AR',
        icon: '10d',
        description: 'Scattered clouds',
        width: 130,
        height: 200,
        country: false),
    const Tarjeta(
        city: 'Paraná',
        temp: '18',
        countryCode: 'AR',
        icon: '10d',
        description: 'Scattered clouds',
        width: 130,
        height: 200,
        country: false),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF0D47A1),
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              city = '';
              setState(() {});
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onSubmitted: (value) {
                city = controller.text;
                setState(() {});
                controller.clear();
              },
            ),
          ),
          const SizedBox(height: 3),
          futureBuilder(city),
          FutureBuilder<CityForecast>(
            future: getForecast(1, 1),
            builder:
                (BuildContext context, AsyncSnapshot<CityForecast> snapshot) {
              if (snapshot.hasData) {
                CityForecast city = snapshot.data!;
                Widget widget;

                city.timezone == 'Pronostico no encontrado'
                    ? widget = Text(city.timezone!)
                    : widget = ForecastCard(
                        dt: '${snapshot.data!.lat}',
                        min:
                            snapshot.data!.daily!.toList().first.dt!.toDouble(),
                        max: snapshot.data!.daily!.first.temp!.max!.toDouble(),
                        icon:
                            '${snapshot.data!.daily!.first.weather!.first.icon}',
                        description:
                            '${snapshot.data!.daily!.first.weather!.first.description}');
                return widget;
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
          )

          /* SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [...cityForecast.map((element) => element).toList()],
              )), */
        ],
      )),
    );
  }
}

Widget futureBuilder(String value) {
  if (value.isEmpty) {
    return Column(
      children: [
        const SizedBox(height: 5),
        FadeIn(
          child: const Text(
            'No se realizo ninguna busqueda',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    );
  } else {
    return FutureBuilder<CityWeather>(
      future: getWeather(value),
      builder: (BuildContext context, AsyncSnapshot<CityWeather> snapshot) {
        if (snapshot.hasData) {
          CityWeather city = snapshot.data!;
          Widget widget;
          city.name! == 'Ciudad no encontrada'
              ? widget = Text(
                  city.name!,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )
              : widget = Tarjeta(
                  city: city.name!,
                  temp: '${city.main!.temp}',
                  countryCode: city.sys!.country!,
                  icon: city.weather!.first.icon!,
                  description: city.weather!.first.description!,
                );
          return widget;
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
