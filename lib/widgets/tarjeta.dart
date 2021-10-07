import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:flutter/widgets.dart';

class Tarjeta extends StatelessWidget {
  final String city;
  final String temp;
  final String countryCode;
  final String icon;
  final String description;
  const Tarjeta(
      {Key? key,
      required this.city,
      required this.temp,
      required this.countryCode,
      required this.icon,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String descriptionUpper = description.toUpperCase();
    return FadeIn(
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(15),
        width: 230,
        height: 300,
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
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1565C0)),
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  temp,
                  style:
                      const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: const [
                    Text(
                      '°c',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )
              ],
            ),
            Image.network(
              'http://openweathermap.org/img/w/$icon.png'
              ,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(descriptionUpper,
                style: const TextStyle(color: Color(0xFF1565C0)))
          ],
        ),
      ),
    );
  }
}
