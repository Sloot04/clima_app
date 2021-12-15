import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:api_clima/models/coor_model.dart';
import 'package:api_clima/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoorModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (_) => AnimatedSplashScreen(
              duration: 200,
              splashIconSize: 200,
              splash: const FaIcon(
                FontAwesomeIcons.cloudSunRain,
                size: 200,
                color: Colors.blue,
              ),
             backgroundColor: const Color(0xFF0D47A1),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,
              nextScreen: const HomePage()),
        },
      ),
    );
  }
}
