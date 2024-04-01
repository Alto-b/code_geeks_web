import 'package:code_geeks_web/presentation/feedback/feedback.dart';
import 'package:code_geeks_web/presentation/join_mentor/mentor_join.dart';
import 'package:code_geeks_web/presentation/my_subscriptions/my_subs.dart';
import 'package:code_geeks_web/presentation/my_subscriptions/subs_history.dart';
import 'package:code_geeks_web/presentation/profile%20page/profile.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
   SettingsPage({super.key});

  bool isMobile = false;

  final screens = [
    ProfilePage(),
    MySubscriptionsPage(),
    SubsHistoryPage(),
    MentorJoinPage(),
    FeedBackPage(),
  ];

  final title = [
    "Profile",
    "Subscriptions",
    "My Activity",
    "Join us",
    "Feedback"
  ];

  final desc = [
    "View/Edit your profile",
    "View your active subscription",
    "View your subscripton history",
    "Be a mentor",
    "Provide feedback"
  ];

  final icons = [
    Icons.person,
    Icons.subscriptions_outlined,
    Icons.history,
    Icons.person_add_alt,
    Icons.feedback
  ];

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                width: screenWidth/2,
                height: screenHeight,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:isMobile?1:2,mainAxisExtent: screenHeight/4), 
                  itemCount: screens.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => screens[index],));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                          ),
                          child: Container(
                            height: screenHeight/6,
                            width: screenWidth/4,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(icons[index],size: screenWidth/15,),
                                      Text(title[index],style: TextStyle(
                                        fontSize: 20
                                      ),)
                                    ],
                                  ),
                                  Text(desc[index])
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}