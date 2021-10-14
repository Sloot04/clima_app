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
              height: width / 20,
            ),
            Row(
              children: [
                Text(
                  '$min',
                  style: TextStyle(
                      fontSize: width / 9, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text(
                      '°c',
                      style: TextStyle(fontSize: width / 10),
                    ),
                    SizedBox(
                      height: width / 10,
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '$max',
                  style: TextStyle(
                      fontSize: width / 9, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text(
                      '°c',
                      style: TextStyle(fontSize: width / 10),
                    ),
                    SizedBox(
                      height: country ? 20 : width / 10,
                    )
                  ],
                ),
              ],
            ),
            Image.network(
              'http://openweathermap.org/img/w/$icon.png',
              scale: 1.5,
            ),
            SizedBox(
              height:  width / 20,
            ),
            Text(descriptionUpper,
                style: TextStyle(color:const Color(0xFF1565C0), fontSize: width / 13))
          ],
        ),
      ),
    );
  }
}
