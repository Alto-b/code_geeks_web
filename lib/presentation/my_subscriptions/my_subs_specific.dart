
import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_geeks_web/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks_web/presentation/chat/chat_page.dart';
import 'package:code_geeks_web/presentation/feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_icon/animated_icon.dart';

// ignore: must_be_immutable
class MySpecificSubsPage extends StatelessWidget {
   MySpecificSubsPage({super.key,required this.state,required this.index});

  MySubscritpionsLoadedState state;
  int index;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(state.mySubsList[index].sub_photo),
            ),
            const SizedBox(width: 8), // Add some space between CircleAvatar and Text
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    state.mySubsList[index].sub_title,
                    style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),   
          ],
        ),
      ),



      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 5,),
             (state.mySubsList[index].subscriptionDetails['videos']?.length > 0)?
              SizedBox(
                height: screenHeight-(screenHeight/7),
                width: screenWidth-20,
                // color: Colors.amber,
                child: ListView.builder(
                  itemCount: state.mySubsList[index].subscriptionDetails['videos']?.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: AnyLinkPreview(
                                      proxyUrl: state.mySubsList[index].subscriptionDetails['videos'][i],
                                      link: state.mySubsList[index].subscriptionDetails['videos'][i],
                                      errorImage: state.mySubsList[index].sub_photo,
                                      displayDirection: UIDirection.uiDirectionHorizontal, 
                                      cache: const Duration(hours: 1),
                                      boxShadow: const [],
                                      removeElevation: false,
                                      backgroundColor: Colors.grey[100], 
                                      errorWidget: Container(
                                      color: Colors.grey[300], 
                                      child: const Text('404! Not Found'), 
                                      ),
                                      ),
                    );
                  },
                  ),
              ):Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight/6,),
                  // Text("Error loading playlist."),
                  CachedNetworkImage(imageUrl: "https://miro.medium.com/v2/resize:fit:1358/0*QOZm9X5er1Y0r5-t",
                  colorBlendMode: BlendMode.difference),
                  const SizedBox(height: 30,),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FeedBackPage(),));
                  }, child: const Text("Report issue !",style: TextStyle(fontSize: 15),))
                ],
              ))
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: state.mySubsList[index].guide_id != '0'
    ? FloatingActionButton(
      backgroundColor: Colors.blueGrey,
      splashColor: Colors.blue,
      onPressed: (){}, 
      // label: Text("Chat with mentor"),
      child: AnimateIcon(
        key: UniqueKey(),
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => SubsChatPage(
            guide_id: state.mySubsList[index].guide_id,
            guide_name: state.mySubsList[index].guide_name,
            guide_photo: state.mySubsList[index].guide_photo,
            sub_lang: state.mySubsList[index].sub_lang,
            sub_title: state.mySubsList[index].sub_title,
            sub_photo: state.mySubsList[index].sub_photo,
            status: state.mySubsList[index].status,
            date: state.mySubsList[index].date,
            expiry: state.mySubsList[index].expiry,
            booking_id: state.mySubsList[index].booking_id,
           ),));
        },
        iconType: IconType.continueAnimation,
        height: 40,
        width: 40,
        color: const Color.fromARGB(255, 241, 241, 241),
        animateIcon: AnimateIcons.chatMessage,
    ))
    : FloatingActionButton.extended(
      backgroundColor: Colors.blueGrey,
      splashColor: Colors.blue,
      onPressed: (){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Sorry for the delay. Still searching for mentors apt for you.",
            style: GoogleFonts.poppins(fontSize: 15),),
          );
        },);
      }, 
      label: const Text("Exploring mentors tailored for you !",style: TextStyle(color: Colors.white),),
      icon: AnimateIcon(
        key: UniqueKey(),
        onTap: () {},
        iconType: IconType.continueAnimation,
        height: 70,
        width: 70,
        color: const Color.fromARGB(255, 110, 138, 185),
        animateIcon: AnimateIcons.clock,
    )
      ),

    );
  }
}