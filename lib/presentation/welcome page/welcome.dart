import 'package:code_geeks_web/presentation/login_page.dart/login.dart';
import 'package:code_geeks_web/presentation/signup_page/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
   WelcomePage({super.key});

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // title: Text(isMobile.toString()),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
          }, child: Text("Login")),
          SizedBox(width: 15,),
          Text("/"),
          SizedBox(width: 15,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
          }, child: Text("SignUp")),
          SizedBox(width: 15,)
        ],
      ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  elevation: 5,
                  child: Container(
                    color: Colors.white,
                    height: 200,width: 200,
                    child: Image.asset('lib/assets/logo.png',fit: BoxFit.cover,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Code Geeks is your ultimate destination for all things coding. Whether you're a seasoned developer or just starting out, our platform offers subscriptions, mentorship programs, and a vibrant community—all in one place. Join us to accelerate your learning journey, connect with like-minded individuals, and unlock your full potential in the world of coding.",
                          textAlign: TextAlign.justify,
                          style: textStyle(),
                          ),
                      ),
                        SizedBox(height: 30,),
                        Divider(endIndent: screenWidth/5,indent: screenWidth/5,),
                        SizedBox(height: 30,),
                        isMobile?Column(
                          children: [
                              Container(
                                height: screenHeight/3,
                                width: screenWidth/4,
                                child: Image.asset('lib/assets/ss1.png')),
                                SizedBox(height: 30,),
                                SizedBox(
                                  width: screenWidth - (screenWidth/6),
                                  child: Text("Code Geeks is revolutionizing the way developers engage with technology by providing a comprehensive platform tailored to their needs. Our platform caters to a wide spectrum of users, ranging from seasoned professionals seeking advanced resources to beginners embarking on their coding journey.At Code Geeks, we understand the importance of continuous learning and growth in the ever-evolving field of technology. That's why we offer a range of subscription plans designed to suit different skill levels and learning objectives. Whether you're interested in mastering a specific programming language, exploring cutting-edge technologies, or preparing for certification exams, our curated content ensures you stay ahead in your career",
                                  textAlign: TextAlign.justify,
                                  style: textStyle(),))
                            ],
                        ):Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: screenHeight/3,
                                width: screenWidth/4,
                                child: Image.asset('lib/assets/ss1.png')),
                                SizedBox(
                                  // height: screenHeight/3,
                                  width: screenWidth - (screenWidth/4)-80,
                                  child: Text("Code Geeks is revolutionizing the way developers engage with technology by providing a comprehensive platform tailored to their needs. Our platform caters to a wide spectrum of users, ranging from seasoned professionals seeking advanced resources to beginners embarking on their coding journey.At Code Geeks, we understand the importance of continuous learning and growth in the ever-evolving field of technology. That's why we offer a range of subscription plans designed to suit different skill levels and learning objectives. Whether you're interested in mastering a specific programming language, exploring cutting-edge technologies, or preparing for certification exams, our curated content ensures you stay ahead in your career",
                                  textAlign: TextAlign.justify,
                                  style: textStyle(),))
                            ],
                          ),
                        ),
                         SizedBox(height: 30,),
                        Divider(endIndent: screenWidth/5,indent: screenWidth/5,),
                        SizedBox(height: 30,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  TextStyle textStyle() {
    return GoogleFonts.poppins(
                  fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey
                );
  }
}