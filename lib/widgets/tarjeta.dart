import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:flutter/widgets.dart';

class Tarjeta extends StatelessWidget {
  final String city;
  final String temp;
  final String countryCode;
  final String icon;
  final String description;
  final double width;
  final double height;

  const Tarjeta({
    Key? key,
    required this.city,
    required this.temp,
    required this.countryCode,
    required this.icon,
    required this.description,
    this.width = 180,
    this.height = 250,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String descriptionUpper = description.toUpperCase();
    return FadeIn(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
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
                    city,
                    style: TextStyle(
                        fontSize: width / 9,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1565C0)),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  margin: const EdgeInsets.only(bottom: 13),
                  height: 20,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Center(
                      child: Text(
                    countryCode,
                    style: const TextStyle(color: Colors.white),
                  )),
                )
              ],
            ),
            SizedBox(
              height: width / 18,
            ),
            Row(
              children: [
                Text(
                  temp,
                  style: TextStyle(
                      fontSize: width / 6, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text(
                      '°c',
                      style: TextStyle(fontSize: width / 8),
                    ),
                    SizedBox(
                      height: width / 10,
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
              height: width / 9,
            ),
            Text(descriptionUpper,
                style: const TextStyle(color: Color(0xFF1565C0)))
          ],
        ),
      ),
    );
  }
}
