import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_web/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks_web/presentation/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionBookingPage extends StatefulWidget {
   const SubscriptionBookingPage({super.key,required this.subId});

  // ignore: prefer_typing_uninitialized_variables
  final subId;

  @override
  State<SubscriptionBookingPage> createState() => _SubscriptionBookingPageState();
}

class _SubscriptionBookingPageState extends State<SubscriptionBookingPage> {

  List<String> plans = ["Basic","Standard","Premium"];

  List<Color> tilebg = [
    const Color.fromARGB(195, 76, 175, 79),
    const Color.fromARGB(182, 255, 235, 59),
    const Color.fromARGB(177, 33, 149, 243)
  ];

  List<int> duration = [3,7,30];

  Razorpay? _razorpay;

   @override
  void initState(){
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  String? bookId;
  Map<String,dynamic> detail = {};
  
 
  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "Payment successful");    
     context.read<SubscriptionBloc>().add(BookSubscriptionEvent(data: detail, bookingId: bookId!));
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SidebarPage(),), (route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "Subscription successfull !");
    context.read<SubscriptionBloc>().add(BookSubscriptionEvent(data: detail, bookingId: bookId!));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SidebarPage(),), (route) => false);
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: "External wallet is  ${response.walletName}");
  }

  void bookSubscription(SubscriptionState state,Map<String,dynamic> data,Map<String,dynamic> ops)async{
    try{

      // Retrieve the specific subscription details from the "subscriptions" collection
    final subscriptionSnapshot = await FirebaseFirestore.instance
        .collection('subscriptions')
        .doc(data['sub_id'])
        .get();
    
    Map<String, dynamic> subscriptionData = subscriptionSnapshot.data() ?? {};

    
        
    String bookingId = FirebaseFirestore.instance.collection("bookings").doc().id;
    Map<String,dynamic> details ={
      "booking_id" : bookingId, 
      "user_id" : data['user_id'],
      "user_name" : data['user_name'],
      "user_avatar" : data['user_avatar'] ?? "https://st4.depositphotos.com/4329009/19956/v/450/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg",
      "date" : data['booking_date'],
      "expiry" : data['expiry_date'],
      "sub_id" : data['sub_id'],
      "sub_title" : data['sub_title'],
      "sub_lang" : data['sub_lang'],
      "sub_photo" : data['sub_photo'],
      "booking_amount" : data['booking_amount'],
      "status" : "pending",
      "guide_id" : "0",
      "guide_name" : "0",
      "guide_photo" : "0",
      'subscriptionDetails': subscriptionData,
    };
    var options ={
                      'key' : "rzp_test_CrySNngXFK5H5o",
                      'amount' : ops['amount'],
                      'name' : ops['name'],
                      'subscritpion' : ops['subscriptions'],
                      'prefill' : ops['prefill']
                    };

    bookId = bookingId;
    detail = details;
    _razorpay?.open(options); 
    }
    catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<SubscriptionBloc>().add(SpecificSubsLoadEvent(SubsId:widget.subId));
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        if(state is SpecificSubsLoadedState){
          return Scaffold(
            appBar: AppBar(),
            body:  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(state.specSubsList[0].title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                            Text(state.specSubsList[0].language)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text("Select a plan to proceed",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),),
                      SizedBox(
                        height: screenHeight-30,
                        width: screenWidth,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                           return  Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Card(
                              elevation: 5,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                               child: Container(
                                height: screenHeight/7,
                                width: screenWidth-30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: tilebg[index]
                                  )
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: ListTile(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Long press to confirm "),backgroundColor: Colors.green,));
                                  },
                                  onLongPress: () {
                                            var options ={
                                              'key' : 'rzp_test_om7emjnNEbQYMJ',
                                              'amount' : '${(int.parse(state.specSubsList[0].amount) * duration[index]*100)}',
                                              'name' : 'CodeFascia',
                                              'description' : state.specSubsList[0].title,
                                              'prefill' : '${FirebaseAuth.instance.currentUser?.email}'
                                            };
                                            var data = {
                                              "user_id" : FirebaseAuth.instance.currentUser!.uid,
                                              "user_name" : '${FirebaseAuth.instance.currentUser!.displayName}',
                                              "user_avatar" : '${FirebaseAuth.instance.currentUser!.photoURL}',
                                              "sub_id" : state.specSubsList[0].subsId,
                                              "sub_title" : state.specSubsList[0].title,
                                              "sub_photo" : state.specSubsList[0].photo,
                                              "sub_lang" : state.specSubsList[0].language,
                                              "booking_date" : DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                              "expiry_date" :DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: duration[index]))) ,
                                              "booking_amount" : '${(int.parse(state.specSubsList[0].amount) * duration[index])}',
                                              };
                                    bookSubscription(state,data,options);
                                  },
                                  splashColor: Colors.white54,
                                  title: Text(plans[index],style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                                  subtitle: Text("Duration : ${duration[index]} days",style: const TextStyle(
                                        fontSize: 20
                                      ),),
                                  trailing: Text("₹ ${int.parse(state.specSubsList[0].amount) * duration[index]}",style: const TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.w500
                                  ),),
                                ),
                                                        ),
                             ),
                           );  
                          },
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          );
        }
  
        return Scaffold(
          body: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Text("Something unexpected occured")),
              IconButton(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SidebarPage(),), (route) => false);
              }, icon: const Icon(Icons.arrow_back_ios))
            ],
          )),
        );
      },
    );
  }
}