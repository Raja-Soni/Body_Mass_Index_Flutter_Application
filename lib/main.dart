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
        primarySwatch: Colors.blue,
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
  var bmiResult='';
  Color bgColor = Colors.indigo.shade500;
  Color chngColor = Colors.white;
  Color cautionBGColor = Colors.indigo.shade500;
  var imgs = ["","assets/images/under_weight_male.png","assets/images/healthy_male.png","assets/images/over_weight_male.png","assets/images/obese_male.png"
    ,"assets/images/under_weight_female.png","assets/images/healthy_female.png","assets/images/over_weight_female.png","assets/images/obese_female.png"];
  var imageIndex=0;
  var genderGroupValue="";
  var gender=['male','female'];

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
        backgroundColor: Colors.indigoAccent,
        title: Text("BMI",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35, color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AnimatedContainer(duration: Duration(seconds: 1),
          color: bgColor,
          child: Center(
            child: Container(
                width: 350,
                height: 700,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [
                        Color(0xff3074f8),
                        Color(0xff2b3483),
                      ],
                    radius:1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
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
                              TextSpan(text: "I", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 35, color: Colors.blue.shade800)),
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
                        Row(
                            children: [
                              Radio(
                                  fillColor: WidgetStatePropertyAll(Colors.white),
                                  overlayColor: WidgetStatePropertyAll(Colors.green),
                                  value: gender[0],
                                  groupValue: genderGroupValue,
                                  onChanged:(value){
                                    setState((){
                                      genderGroupValue=value.toString();
                                    });
                            }),
                              Text("Male", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white)),
                              SizedBox(width: 20,),
                              Radio(
                                fillColor: WidgetStatePropertyAll(Colors.white),
                                overlayColor: WidgetStatePropertyAll(Colors.green),
                                value: gender[1],
                                groupValue: genderGroupValue,
                                onChanged: (value){
                                  setState((){
                                    genderGroupValue=value.toString();
                                  });
                                },),
                              Text("Female", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white)),
                            ]
                        ),
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 40, width: 100,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                )
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: RadialGradient(
                                      colors: [
                                        Color(0xff3575f8),
                                        Color(0xff15278c),],
                                      center: Alignment.center,
                                      radius: 1.5
                                  ),
                              ),
                              child: FloatingActionButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusColor: Colors.green,
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                splashColor: Colors.green.shade800,
                                  onPressed: (){
                                    var givenWeight = weightCont.text.toString().trim();
                                    var givenFoots = footHeightCont.text.toString().trim();
                                    var givenInches = inchHeightCont.text.toString().trim();
                                    var givenGender = genderGroupValue.toString().trim();
        
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
                                      else if(givenGender.isEmpty){
                                        setState((){
                                          bmiResult ="Please Select Your Gender!!!";
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
                                          if (bmi <= 18.5) {
                                            bgColor = Colors.red;
                                            chngColor = bgColor;
                                            cautionBGColor = Colors.indigo;
                                            if(genderGroupValue=="male"){
                                            imageIndex = 1;
                                            }
                                            else{
                                              imageIndex = 5;
                                            }
                                            bmiResult =
                                            "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Underweight!!!";
                                          }
                                          else if (bmi >= 25 && bmi <= 29.9) {
                                            bgColor = Colors.orange;
                                            chngColor = bgColor;
                                            if(genderGroupValue=="male"){
                                              imageIndex = 3;
                                            }
                                            else{
                                              imageIndex = 7;
                                            }
                                            cautionBGColor = Colors.indigo;
                                            bmiResult =
                                            "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Overweight!!!";
                                          }
                                          else if (bmi > 30) {
                                            bgColor = Colors.red;
                                            chngColor = bgColor;
                                            cautionBGColor = Colors.indigo;
                                            if(genderGroupValue=="male"){
                                              imageIndex = 4;
                                            }
                                            else{
                                              imageIndex = 8;
                                            }
                                            bmiResult =
                                            "Your BMI is: ${bmi.toStringAsFixed(2)} \nYou are Obese!!!";
                                          }
                                          else {
                                            bgColor = Colors.green;
                                            chngColor = bgColor;
                                            cautionBGColor = Colors.indigo;
                                            if(genderGroupValue=="male"){
                                              imageIndex = 2;
                                            }
                                            else{
                                              imageIndex = 6;
                                            }
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
                          ),
                        ),
                        SizedBox(height: 15,),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1
                              )
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: RadialGradient(
                                  colors: [
                                    Color(0xff3074f8),
                                    Color(0xff15278c),],
                                  center: Alignment.center,
                                  radius: 1.3
                                ),
                              ),
                              child: FloatingActionButton(
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  focusColor: Colors.green,
                                  splashColor: Colors.green.shade800,
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
                                    genderGroupValue="";
                                  });
                                  },
                                  child: Text("Reset")
                              ),
                            ),
                          ),
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
                        SizedBox(height: 10,),
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
        ),
      )
    );
  }
}
