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
      this.width = 180,
      this.height = 250,
      this.country = true,
      required this.min,
      required this.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String descriptionUpper = description.toUpperCase();
    return FadeIn(
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(15),
        width: width,
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xFFFFF8E1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    dt,
                    style: TextStyle(
                        fontSize: width / 9,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1565C0)),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            SizedBox(
              height: country ? 10 : width / 18,
            ),
            Row(
              children: [
                Text(
                  '$min',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    const Text(
                      '°c',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: country ? 20 : width / 10,
                    )
                  ],
                ),
                Text(
                  '$max',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    const Text(
                      '°c',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: country ? 20 : width / 10,
                    )
                  ],
                )
              ],
            ),
            Image.network(
              'http://openweathermap.org/img/w/$icon.png',
              scale: 1.5,
            ),
            SizedBox(
              height: country ? 20 : width / 9,
            ),
            Text(descriptionUpper,
                style: const TextStyle(color: Color(0xFF1565C0)))
          ],
        ),
      ),
    );
  }
}
