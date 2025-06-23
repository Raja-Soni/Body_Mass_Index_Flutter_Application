import 'package:bmiapp/custom_widgets/custom_input_text_field.dart';
import 'package:bmiapp/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
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
  var footHeightCont = TextEditingController();
  var inchHeightCont= TextEditingController();
  var weightCont= TextEditingController();
  var bmiResult="";
  Color bgColor = Colors.indigo.shade500;
  Color chngColor = Colors.white;
  Color cautionBGColor = Colors.indigo.shade500;
  var imgs = ["","assets/images/under_weight.png","assets/images/healthy.png","assets/images/over_weight.png","assets/images/obese.png"];
  var imageIndex=0;

  @override
  void dispose() {
    weightCont.dispose();
    footHeightCont.dispose();
    inchHeightCont.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("BMI",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 35, color: Colors.white)),
        centerTitle: true,
      ),
      body: AnimatedContainer(duration: Duration(seconds: 1),
        color: bgColor,
        child: Center(
          child:  Container(
              width: 350,
              height: 700,
              decoration: BoxDecoration(
                color: Colors.indigo.shade500,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 5,
                  color: Colors.white,
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:30,left:15,right:15),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: RichText(text:
                          TextSpan(children:[
                            TextSpan(text: "B", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 35, color: Colors.red)),
                            TextSpan(text: "M", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30, color: Colors.green)),
                            TextSpan(text: "I", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25, color: Colors.blue.shade800)),
                            TextSpan(text: " Application", style: TextStyle(fontWeight: FontWeight.w600, color: bgColor, fontSize: 35))
                          ])
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      CustomTextField(
                        control: weightCont,
                        hintText: "Enter Weight in Kgs...",
                        icon: Icon(Icons.monitor_weight_outlined),
                        iconColor: Colors.red,),
                      SizedBox(height: 20,),
                      CustomTextField(
                        control: footHeightCont,
                        hintText: "Enter Height in Foots...",
                        icon: Icon(Icons.height),
                        iconColor: Colors.green,
                      ),
                      SizedBox(height: 20,),
                      CustomTextField(
                        control: inchHeightCont,
                        hintText: "Enter Height in Inches...",
                        icon: Icon(Icons.height),
                        iconColor: Colors.blue,),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 40, width: 100,
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusColor: Colors.green,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo.shade700,
                          splashColor: Colors.blue.shade800,
                            onPressed: (){
                              var givenWeight = weightCont.text.toString().trim();
                              var givenFoots = footHeightCont.text.toString().trim();
                              var givenInches = inchHeightCont.text.toString().trim();

                              if(givenWeight.isNotEmpty && givenFoots.isNotEmpty && givenInches.isNotEmpty){
                                try{
                                var weight = int.parse(givenWeight);
                                var foots = int.parse(givenFoots);
                                var inches = int.parse(givenInches);

                                if(weight <= 2 || foots<=2 || inches<0){
                                  setState(() {
                                    bmiResult ="Enter Correct Values: \nWeight > 2 \nFoot > 2  \nInches >= 0";
                                    bgColor = Colors.yellow;
                                    chngColor=Colors.black;
                                    imageIndex = 0;
                                    cautionBGColor = Colors.yellow;
                                  });
                                }
                                else {
                                  var totalInches = (foots * 12) + inches;
                                  var totalCM = totalInches * 2.54;
                                  var totalMeters = totalCM / 100;
                                  var bmi = weight / (totalMeters * totalMeters);
                                  setState(() {
                                    if (bmi < 18.5) {
                                      bgColor = Colors.red;
                                      chngColor = bgColor;
                                      cautionBGColor = Colors.indigo;
                                      imageIndex = 1;
                                      bmiResult =
                                      "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Underweight!!!";
                                    }
                                    else if (bmi >= 25 && bmi <= 29.9) {
                                      bgColor = Colors.orange;
                                      chngColor = bgColor;
                                      imageIndex = 3;
                                      cautionBGColor = Colors.indigo;
                                      bmiResult =
                                      "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Overweight!!!";
                                    }
                                    else if (bmi > 30) {
                                      bgColor = Colors.red;
                                      chngColor = bgColor;
                                      cautionBGColor = Colors.indigo;
                                      imageIndex = 4;
                                      bmiResult =
                                      "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Obese!!!";
                                    }
                                    else {
                                      bgColor = Colors.green;
                                      chngColor = bgColor;
                                      cautionBGColor = Colors.indigo;
                                      imageIndex = 2;
                                      bmiResult =
                                      "Your BMI is: ${bmi.toStringAsFixed(2)}  \nYou are Healthy...";
                                    }
                                  });
                                }
                                }
                                catch(e){
                                  setState(() {
                                    bmiResult ="Please Fill Number Only in all the Fields";
                                    bgColor = Colors.yellow;
                                    chngColor=Colors.black;
                                    cautionBGColor = Colors.yellow;
                                    imageIndex = 0;
                                  });
                                }
                              }
                              else{
                                setState(() {
                                  bmiResult ="Please Fill All the Fields";
                                  chngColor=Colors.black;
                                  cautionBGColor = Colors.yellow;
                                  bgColor = cautionBGColor;
                                  imageIndex = 0;
                                });
                              }
                              }, child: Text("Calculate")
                        ),
                      ),
                      SizedBox(height: 15,),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: FloatingActionButton(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.indigo.shade700,
                            focusColor: Colors.green,
                            splashColor: Colors.blue.shade800,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          onPressed: (){
                            setState(() {
                              weightCont.clear();
                              footHeightCont.clear();
                              inchHeightCont.clear();
                              bmiResult="";
                              imageIndex = 0;
                              bgColor = Colors.indigo.shade500;
                              chngColor=Colors.white;
                              cautionBGColor=bgColor;
                            });

                            }, child: Text("Reset")),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          decoration: bmiResult.isNotEmpty ? BoxDecoration(
                              color: cautionBGColor,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                width: 2,
                                color: chngColor,
                              )
                          ): null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(bmiResult,
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(
                                    fontSize: 20,
                                    color: chngColor,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      imageIndex != 0 ? Image.asset(
                        imgs[imageIndex],
                        height: 180,
                        width: 180,
                      ): SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
          ),
        ),
      )
    );
  }
}
