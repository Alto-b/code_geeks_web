import 'package:code_geeks_web/presentation/homepage/widgets/lang_widget.dart';
import 'package:code_geeks_web/presentation/homepage/widgets/mentor_card_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LanguageWidget(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),
          SizedBox(height: 50,),
          MentorCardHPWidget(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth)
        ],
      ),
    );
  }
}