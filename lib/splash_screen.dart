import 'package:bmiapp/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  var colorsArray = [Colors.green.shade500, Colors.blue.shade500];
  var bgColor = Colors.red.shade500;
  int index = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        bgColor = colorsArray[0];
        index++;
      });
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        bgColor = colorsArray[1];
        index++;
      });
    });
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: MyHomePage(),
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        height: double.infinity,
        width: double.infinity,
        duration: Duration(milliseconds: 800),
        color: bgColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/bmi_logo.png",
                height: 180,
                width: 300,
                fit: BoxFit.fill,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 100,
                    fontFamily: 'titleFontType',
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "B",
                      style: TextStyle(
                        color: index == 0 ? Colors.red.shade700 : Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "M",
                      style: TextStyle(
                        color: index == 1
                            ? Colors.green.shade700
                            : Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "I",
                      style: TextStyle(
                        color: index == 2 ? Colors.blue.shade700 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
