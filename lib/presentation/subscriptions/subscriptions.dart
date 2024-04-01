import 'package:code_geeks_web/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks_web/presentation/subscriptions/widget/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionsPage extends StatelessWidget {
   SubscriptionsPage({super.key});

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {

    context.read<SubscriptionBloc>().add(SubscriptionLoadEvent());
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final searchController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text("Subscriptions",style: GoogleFonts.orbitron(
             fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey,
              ),textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth/2,
                 decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35)
                            ),
                            child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  context.read<SubscriptionBloc>().add(SearchSubscriptionsEvent(searchWord: value));
                },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder( 
                            borderRadius: BorderRadius.circular(35)
                          ),
                          prefixIcon: InkWell(
                            onTap: () {
                              //search button
                            },
                            child: const Icon(Icons.search,color: Colors.grey,)),
                        ),
                      ),
                          ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
        
              SizedBox
              ( 
                // color: Colors.amber,
                height: screenHeight-200,
                width: screenWidth,
                child: SubscriptionCard(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth,isMobile: isMobile),

              ),
              const SizedBox(height: 450,)
            ],
          ),
        ),
      ),
    );
  }
}
