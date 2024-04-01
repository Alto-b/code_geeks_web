// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:code_geeks_web/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks_web/presentation/sidebar.dart';
import 'package:code_geeks_web/presentation/subscriptions/booking_subs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SpecificSubsPage extends StatefulWidget {
   const SpecificSubsPage({super.key,required this.subsId});

  final subsId;

  @override
  State<SpecificSubsPage> createState() => _SpecificSubsPageState();
}

class _SpecificSubsPageState extends State<SpecificSubsPage> {
  int duration=1;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    context.read<SubscriptionBloc>().add(SpecificSubsLoadEvent(SubsId: widget.subsId));

    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        if(state is SpecificSubsLoadedState){
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async{
                 Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SidebarPage()),
                              (route) => false,
                            );
            },
            child: Scaffold(    
              appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
               decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(state.specSubsList[0].photo),
                      fit: BoxFit.cover
                   ),
              ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 15,
                        left: 5,
                        child: IconButton(
                          style: const ButtonStyle(
                            iconSize: MaterialStatePropertyAll(30),
                            iconColor:MaterialStatePropertyAll(Colors.white),
            
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SidebarPage()),
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ],
                  ),
                ),
                toolbarHeight: screenHeight / 3,
                backgroundColor: Colors.grey,
                
              ),
            
              
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(state.specSubsList[0].title,style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                          ),),
                          trailing: Text("₹ ${state.specSubsList[0].amount}/day"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(state.specSubsList[0].LangImg),
                            ),
                            tileColor: Colors.black12,
                            title: Text(state.specSubsList[0].language,style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                            ),),
                            trailing: IconButton(onPressed: (){
                              showDialog<void>(
                                            context: context,
                                            barrierDismissible: true, 
                                            barrierColor: Colors.black87,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                // backgroundColor: Colors.white,
                                                icon:Image.network(state.specSubsList[0].LangImg,height: 35,) ,
                                                title:  Text(state.specSubsList[0].language),
                                                content:  SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(state.specSubsList[0].LangDesc,style: const TextStyle(fontSize: 20),),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Icon(Icons.arrow_back_ios_new),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                            }, icon: const Icon(Icons.read_more)),
                          ),
                        ),
                
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(state.specSubsList[0].description,style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,fontSize: 18
                          ),),
                        ),
                        const Divider(),
                        const SizedBox(height: 60,),
                        Center(
                          child: SizedBox(
                            width: screenWidth/3,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.green)
                              ),
                              onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionBookingPage(subId: state.specSubsList[0].subsId),));
                            }, child: Text("Subscribe Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),    
             ),
          );
        }
        //if error loading the page --> shimmer
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SidebarPage(),), (route) => false);
            }, icon: const Icon(Icons.arrow_back_ios)),
            titleSpacing: 2,
            title: const Text("back",style: TextStyle(
              fontSize: 15
            ),),
          ),
          body: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black
                    ),
                  ),const SizedBox(height: 20,),
                  Container(
                    height: 400,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
  }
}