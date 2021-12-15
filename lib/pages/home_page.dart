import 'package:api_clima/helpers/read_time_stamp.dart';
import 'package:api_clima/models/coor_model.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:api_clima/class/city_forecast.dart';

import 'package:api_clima/widgets/forecast_card.dart';

import 'package:api_clima/class/city_weather.dart';
import 'package:api_clima/helpers/get_weather.dart';
import 'package:api_clima/widgets/tarjeta.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  String city = '';
  List cityForecast = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coor = Provider.of<CoorModel>(context, listen: true);

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
              coor.isWeather = false;
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
                  coor.isWeather = false;

                  setState(() {});
                  controller.clear();
                },
              ),
            ),
            weatherBuilder(city),
            coor.isWeather
                ? forecastBuilder(lon: coor.lon, lat: coor.lat)
                : const Text("")
          ],
        ),
      ),
    );
  }

  FutureBuilder<CityForecast> forecastBuilder({lon, lat}) {
    return FutureBuilder<CityForecast>(
      future: getForecast(lat: lat, lon: lon),
      builder: (BuildContext context, AsyncSnapshot<CityForecast> snapshot) {
        final size = MediaQuery.of(context).size;
        if (snapshot.hasData) {
          List<Daily> city = snapshot.data!.daily!;
          String timezone = snapshot.data!.timezone!;
          cityForecast = city;
          cityForecast.removeAt(0);

          Widget widget;

          timezone == 'Pronostico no encontrado'
              ? widget = Text(timezone)
              : widget = SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...cityForecast.map(
                        (element) => ForecastCard(
                            width: size.width * 0.38,
                            height: size.height * 0.3,
                            dt: readTimestamp(element.dt),
                            min: element.temp!.min!,
                            max: element.temp!.max!,
                            icon: '${element.weather!.first.icon}',
                            description:
                                '${element.weather!.first.description}'),
                      ),
                    ],
                  ),
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

Widget weatherBuilder(String value) {
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
        final size = MediaQuery.of(context).size;
        final coor = Provider.of<CoorModel>(context);

        if (snapshot.hasData) {
          CityWeather city = snapshot.data!;
          Widget widget;
          if (city.name! == 'Ciudad no encontrada') {
            widget = Text(
              city.name!,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            );
          } else {
            coor.lat = city.coord!.lat!;
            coor.lon = city.coord!.lon!;
            widget = Column(
              children: [
                Tarjeta(
                  width: size.width * 0.4,
                  height: size.height * 0.32,
                  city: city.name!,
                  temp: '${city.main!.temp}',
                  countryCode: city.sys!.country!,
                  icon: city.weather!.first.icon!,
                  description: city.weather!.first.description!,
                ),
                coor.isWeather
                    ? const SizedBox()
                    : ElevatedButton(
                        onPressed: () {
                          coor.isWeather = true;
                        },
                        child: const Text("Extended forecast")),
              ],
            );
          }

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
