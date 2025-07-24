import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bmiapp/splash_screen.dart';
import 'package:flutter/material.dart';

import 'custom_widgets/custom_input_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var bmiResult = '';
  Color bgColor = Colors.indigo.shade500;
  Color chngColor = Colors.white;
  Color cautionBGColor = Colors.indigo.shade500;
  var imgs = [
    "",
    "assets/images/under_weight_male.png",
    "assets/images/healthy_male.png",
    "assets/images/over_weight_male.png",
    "assets/images/obese_male.png",
    "assets/images/under_weight_female.png",
    "assets/images/healthy_female.png",
    "assets/images/over_weight_female.png",
    "assets/images/obese_female.png",
  ];
  var imageIndex = 0;
  var selectedGenderValue = "";
  var gender = ['male', 'female'];

  bool showTitileAnimation = false;

  int givenWeight = 0;
  int givenFoots = 0;
  int givenInches = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      showTitileAnimation = true;
      setState(() {});
    });
  }

  bool showLogo = false;
  void validationAnimation() {
    bgColor = Colors.indigo.shade500;
    cautionBGColor = Colors.indigo.shade500;
    chngColor = Colors.black;
    bmiResult = "";
    imageIndex = 0;
    setState(() {});
  }

  void resetApp() {
    setState(() {
      bmiResult = "";
      imageIndex = 0;
      bgColor = Colors.indigo.shade500;
      chngColor = Colors.white;
      cautionBGColor = bgColor;
      formKey.currentState!.reset();
      selectedGenderValue = "";
      showLogo = true;
      showTitileAnimation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade800,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showTitileAnimation == true)
                AnimatedTextKit(
                  pause: Duration(milliseconds: 500),
                  animatedTexts: [
                    ScaleAnimatedText(
                      "BODY",
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.red,
                        fontFamily: 'titleFontType',
                      ),
                      duration: Duration(milliseconds: 1000),
                    ),
                    ScaleAnimatedText(
                      "MASS",
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.green,
                        fontFamily: 'titleFontType',
                      ),
                      duration: Duration(milliseconds: 1000),
                    ),
                    ScaleAnimatedText(
                      "INDEX",
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.blue,
                        fontFamily: 'titleFontType',
                      ),
                      duration: Duration(milliseconds: 1000),
                    ),
                  ],
                  totalRepeatCount: 1,
                  onFinished: () {
                    showLogo = true;
                    showTitileAnimation = false;
                    setState(() {});
                  },
                ),
              if (showLogo == true)
                InkWell(
                  splashColor: Colors.grey.shade800,
                  onTap: () {
                    showLogo = false;
                    showTitileAnimation = true;
                    setState(() {});
                  },
                  child: Image.asset(
                    "assets/images/bmi_logo.png",
                    height: 50,
                    width: 80,
                    fit: BoxFit.fill,
                  ),
                ),
            ],
          ),
        ),
        body: AnimatedContainer(
          duration: Duration(seconds: 1),
          color: bgColor,
          child: Center(
            child: Container(
              width: 350,
              height: 700,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2b3483),
                    Color(0xff3074f8),
                    Color(0xff2b3483),
                  ],
                  // radius:1,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 4, color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: 3, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: RichText(
                            text: TextSpan(
                              //Default Values for TextStyle
                              style: TextStyle(
                                fontFamily: 'titleFontType',
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                              children: [
                                TextSpan(
                                  text: "B",
                                  style: TextStyle(color: Colors.red),
                                ),
                                TextSpan(
                                  text: "M",
                                  style: TextStyle(color: Colors.green),
                                ),
                                TextSpan(
                                  text: "I ",
                                  style: TextStyle(color: Colors.blue.shade800),
                                ),
                                TextSpan(
                                  text: "Application",
                                  style: TextStyle(color: bgColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomFormTextField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  validationAnimation();
                                  return "Please enter you weight in Kgs..";
                                } else if (RegExp(
                                  r'[a-zA-Z]',
                                ).hasMatch(value)) {
                                  validationAnimation();
                                  return "Only numbers are allowed.";
                                }
                                int val = int.parse(value.toString().trim());
                                if (val <= 2) {
                                  validationAnimation();
                                  return "Weight should be more than 2 kg";
                                } else {
                                  return null;
                                }
                              },
                              savedValue: (value) {
                                givenWeight = int.parse(value!.trim());
                                return null;
                              },
                              hintText: "Enter Weight in Kgs...",
                              icon: Icon(Icons.monitor_weight_outlined),
                              iconColor: Colors.red,
                            ),
                            SizedBox(height: 20),
                            CustomFormTextField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  validationAnimation();
                                  return "Please enter you height in Foot..";
                                } else if (RegExp(
                                  r'[a-zA-Z]',
                                ).hasMatch(value)) {
                                  validationAnimation();
                                  return "Only numbers are allowed.";
                                }
                                int val = int.parse(value.trim());
                                if (val <= 2) {
                                  validationAnimation();
                                  return "Height should be more than 2 foot";
                                } else {
                                  return null;
                                }
                              },
                              savedValue: (value) {
                                givenFoots = int.parse(value!.trim());
                                return null;
                              },
                              hintText: "Enter Height in Foots...",
                              icon: Icon(Icons.height),
                              iconColor: Colors.green,
                            ),
                            SizedBox(height: 20),
                            CustomFormTextField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  validationAnimation();
                                  return "Please enter you weight in Inches...";
                                } else if (RegExp(
                                  r'[a-zA-Z]',
                                ).hasMatch(value)) {
                                  validationAnimation();
                                  return "Only numbers are allowed.";
                                }
                                int val = int.parse(value.trim());
                                if (val < 0) {
                                  return "Only positive numbers are allowed.";
                                } else {
                                  return null;
                                }
                              },
                              savedValue: (value) {
                                givenInches = int.parse(value!.trim());
                                return null;
                              },
                              hintText: "Enter Height in Inches...",
                              icon: Icon(Icons.height),
                              iconColor: Colors.blue,
                            ),
                            SizedBox(height: 5),
                            FormField(
                              initialValue: selectedGenderValue,
                              validator: (value) {
                                if (selectedGenderValue.isEmpty) {
                                  validationAnimation();
                                  return "Please select your gender";
                                } else {
                                  return null;
                                }
                              },
                              builder: (field) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          fillColor: WidgetStatePropertyAll(
                                            Colors.white,
                                          ),
                                          overlayColor: WidgetStatePropertyAll(
                                            Colors.green,
                                          ),
                                          value: gender[0],
                                          groupValue: selectedGenderValue,
                                          onChanged: (value) {
                                            setState(() {
                                              // gender[0].toString(); value will be assigned to genderGroupValue which was initially empty string
                                              selectedGenderValue = value
                                                  .toString();
                                            });
                                          },
                                        ),
                                        Text(
                                          "Male",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Radio(
                                          fillColor: WidgetStatePropertyAll(
                                            Colors.white,
                                          ),
                                          overlayColor: WidgetStatePropertyAll(
                                            Colors.green,
                                          ),
                                          value: gender[1],
                                          groupValue: selectedGenderValue,
                                          onChanged: (value) {
                                            setState(() {
                                              // gender[1].toString(); value will be assigned to genderGroupValue which was initially empty string
                                              selectedGenderValue = value
                                                  .toString();
                                            });
                                          },
                                        ),
                                        Text(
                                          "Female",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (field.hasError)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12.0,
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          field.errorText ?? '',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: RadialGradient(
                                      colors: [
                                        Color(0xff3575f8),
                                        Color(0xff15278c),
                                      ],
                                      center: Alignment.center,
                                      radius: 1.5,
                                    ),
                                  ),
                                  child: FloatingActionButton(
                                    heroTag: null,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusColor: Colors.green.shade800,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    splashColor: Colors.green,
                                    onPressed: () {
                                      bool validated = formKey.currentState!
                                          .validate();

                                      if (validated) {
                                        formKey.currentState!.save();
                                        var weight = givenWeight;
                                        var foots = givenFoots;
                                        var inches = givenInches;
                                        var totalInches = (foots * 12) + inches;
                                        var totalCM = totalInches * 2.54;
                                        var totalMeters = totalCM / 100;
                                        var bmi =
                                            weight /
                                            (totalMeters * totalMeters);
                                        setState(() {
                                          if (bmi <= 18.5) {
                                            bgColor = Colors.red;
                                            chngColor = bgColor;
                                            cautionBGColor = Colors.indigo;
                                            if (selectedGenderValue == "male") {
                                              imageIndex = 1;
                                            } else {
                                              imageIndex = 5;
                                            }
                                            bmiResult =
                                                "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Underweight!!!";
                                          } else if (bmi >= 25 && bmi <= 29.9) {
                                            bgColor = Colors.orange;
                                            chngColor = bgColor;
                                            if (selectedGenderValue == "male") {
                                              imageIndex = 3;
                                            } else {
                                              imageIndex = 7;
                                            }
                                            cautionBGColor = Colors.indigo;
                                            bmiResult =
                                                "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Overweight!!!";
                                          } else if (bmi > 30) {
                                            bgColor = Colors.red;
                                            chngColor = bgColor;
                                            cautionBGColor = Colors.indigo;
                                            if (selectedGenderValue == "male") {
                                              imageIndex = 4;
                                            } else {
                                              imageIndex = 8;
                                            }
                                            bmiResult =
                                                "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Obese!!!";
                                          } else {
                                            bgColor = Colors.green;
                                            chngColor = bgColor;
                                            cautionBGColor = Colors.indigo;
                                            if (selectedGenderValue == "male") {
                                              imageIndex = 2;
                                            } else {
                                              imageIndex = 6;
                                            }
                                            bmiResult =
                                                "Your BMI is: ${bmi.toStringAsFixed(2)}  \nYou are Healthy...";
                                          }
                                        });
                                      } else {
                                        return;
                                      }
                                    },
                                    child: Text(
                                      "Calculate",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: RadialGradient(
                                      colors: [
                                        Color(0xff3074f8),
                                        Color(0xff15278c),
                                      ],
                                      center: Alignment.center,
                                      radius: 1.3,
                                    ),
                                  ),
                                  child: FloatingActionButton(
                                    heroTag: null,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    focusColor: Colors.green.shade800,
                                    splashColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onPressed: () {
                                      resetApp();
                                    },
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: bmiResult.isNotEmpty
                                  ? BoxDecoration(
                                      color: Colors.indigo.shade800,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        width: 2,
                                        color: chngColor,
                                      ),
                                    )
                                  : null,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  bmiResult,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: chngColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            imageIndex != 0
                                ? Image.asset(
                                    imgs[imageIndex],
                                    height: 180,
                                    width: 180,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
