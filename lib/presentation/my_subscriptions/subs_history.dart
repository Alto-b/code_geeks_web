import 'package:animated_icon/animated_icon.dart';
import 'package:code_geeks_web/application/history_bloc/history_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:timelines/timelines.dart';

class SubsHistoryPage extends StatelessWidget {
  const SubsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth =  MediaQuery.of(context).size.width;
    double screenHeight =  MediaQuery.of(context).size.height;
    context.read<HistoryBloc>().add(HistoryLoadEvent(uid: FirebaseAuth.instance.currentUser!.uid));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription History"),
        // centerTitle: true,
        titleTextStyle: GoogleFonts.orbitron(
          fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                if(state is HistoryLoadedState){
                  return SizedBox(
                    // color: Colors.amber,
                    width: screenWidth,
                    height: screenHeight-(screenHeight/8),
                    child: Timeline.tileBuilder(
                          builder: TimelineTileBuilder.fromStyle(
                            contentsAlign: ContentsAlign.alternating,
                            connectorStyle: ConnectorStyle.dashedLine,
                            indicatorStyle: IndicatorStyle.outlined,
                            contentsBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                      _buildStatusWidget(index,state),
                                      Text("${state.historyList[index].sub_title}  /  ${state.historyList[index].sub_lang}",style: GoogleFonts.poppins(
                                        fontSize: 12,fontWeight: FontWeight.w600
                                      ),),
                                  const SizedBox(height: 5,),
                                  Text(state.historyList[index].date),
                                  const Text("       |   "),
                                  Text(state.historyList[index].expiry),
                                  const SizedBox(height: 5,)
                                ],
                              ),
                            ),
                            itemCount: state.historyList.length,
                          ),
                        ),
                        
                  );
                }
                else if(state is HistoryEmptyState){
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight/4,),
                        Text("No History Found",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey),),
                        // AnimatedIcon(icon: AnimatedIcons.ellipsis_search, progress:kAlwaysCompleteAnimation,size: 50,color: Colors.grey,)
                        AnimateIcon(
                          key: UniqueKey(),
                          onTap: () {},
                          iconType: IconType.continueAnimation,
                          height: 70,
                          width: 70,
                          color:Colors.grey,
                          animateIcon: AnimateIcons.calendar,
                      )
                                        ],
                    ),
                  );
                }
                else{
                    return Center(child: Lottie.asset('lib/assets/loader.json',height: 130,width: 130),);
                }
                
              },
            )
          ],
        ),
      ),
    );
  }


  Widget _buildStatusWidget(int index,HistoryLoadedState state) {
  if (state.historyList[index].status == "ongoing") {
    return Text(
      "Ongoing",
      style: GoogleFonts.orbitron(
        fontSize: 10,
        color: Colors.green,
        fontWeight: FontWeight.w600,
      ),
    );
  } else if (state.historyList[index].status == "pending") {
    return Text(
      "pending",
      style: GoogleFonts.orbitron(
        fontSize: 10,
        color: Colors.orange,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  else{
    return Text(
      "completed",
      style: GoogleFonts.orbitron(
        fontSize: 10,
        color: Colors.red,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}


}