import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:flutter/widgets.dart';

class ForecastCard extends StatelessWidget {
  final String dt;
  final double min;
  final double max;
  final String icon;
  final String description;
  final double width;
  final double height;
  final bool country;
  const ForecastCard(
      {Key? key,
      required this.dt,
      required this.icon,
      required this.description,
      this.width = 100,
      this.height = 190,
      this.country = true,
      required this.min,
      required this.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String descriptionUpper = description.toUpperCase();
    return FadeIn(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        width: width,
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xFFFFF8E1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              dt,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1565C0)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  min.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: const [
                    Text(
                      '°c',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  max.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: const [
                    Text(
                      '°c',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            ),
            Image.network(
              'http://openweathermap.org/img/w/$icon.png',
              scale: 1.5,
            ),
            Text(descriptionUpper,
                style: const TextStyle(
                    color:  Color(0xFF1565C0), fontSize: 13))
          ],
        ),
      ),
    );
  }
}
