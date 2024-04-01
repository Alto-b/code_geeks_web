// ignore_for_file: non_constant_identifier_names,unused_local_variable

import 'dart:io';

// import 'package:CodeFascia/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class SubsChatPage extends StatefulWidget {
   SubsChatPage({
    super.key,
    required this.guide_id,
    required this.guide_name,
    required this.guide_photo,
    required this.status,
    required this.sub_title,
    required this.sub_lang,
    required this.sub_photo,
    required this.date,
    required this.expiry,
    required this.booking_id
    });

  String guide_id;
  String guide_name;
  String guide_photo;
  String status;
  String sub_title;
  String sub_lang;
  String sub_photo;
  String date;
  String expiry;
  String booking_id;

  @override
  State<SubsChatPage> createState() => _SubsChatPageState();
}

class _SubsChatPageState extends State<SubsChatPage> {
  // XFile? newImge;

  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  final TextEditingController _content = TextEditingController();

  late ScrollController _scrollController;

  String? previousDate;

    @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(const Duration(milliseconds: 700), () {
    _scrollToBottom();
  });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    DateTime currentDate = DateTime.now();
    String currentDateString = "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
  
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference chatRef = FirebaseDatabase.instance.ref().child(widget.booking_id);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios,size: 20,)),
      title: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(widget.guide_photo),radius: 20,),
          const SizedBox(width: 10,),
          Text(widget.guide_name,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,)
        ],
      ),
),


      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(child: StreamBuilder(
                stream: chatRef.onValue, 
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                     Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                          List<dynamic> list = map.values.toList();
                          for (var chat in list) {
                            if (chat['dateTime'] is String) {
                              // Parse the ISO 8601 string to a DateTime object
                              chat['dateTime'] = DateTime.parse(chat['dateTime']);
                            }
                          }
                          list.sort((a, b) => b['dateTime'].compareTo(a['dateTime']));
                          list = list.reversed.toList();
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          String messageDate = list[index]['dateTime'].toString().substring(0, 10);
                        bool displayDate = false;
                        if (previousDate == null || messageDate != previousDate) {
                          displayDate = true;
                          previousDate = messageDate;
                        }
                          return (list[index]['senderId']==user!.uid)?
                          //send bubble
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (displayDate)
                              Center(child: Text(messageDate == currentDateString ? "Today" : messageDate.substring(0, 10),style: DateTextStyle(),)),
                              ChatBubble(
                                  clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                                  alignment: Alignment.topRight,
                                  margin: const EdgeInsets.only(top: 20),
                                  backGroundColor: Colors.blue,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: (list[index]['content_type'] == "text")
                                              ? Text(
                                                  list[index]['content'],
                                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                                )
                                              : Container(
                                                  height: 100,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: NetworkImage(list[index]['content']),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(width: 10),
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(list[index]['avatar']),
                                          radius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(list[index]['dateTime'].toString().substring(10,16),style: TimeTextStyle(),),
                                    const SizedBox(width: 20,)
                                  ],
                                ),
                            ],
                          )
                              :
                            //recieve bubble
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (displayDate)
                              Center(child: Text(messageDate == currentDateString ? "Today" : messageDate.substring(0, 10),style: DateTextStyle(),)),
                              ChatBubble(
                                  clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                                  backGroundColor: const Color(0xffE7E7ED),
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(list[index]['avatar']),
                                          radius: 10,
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: (list[index]['content_type'] == "text")
                                              ? Text(
                                                  list[index]['content'],
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(255, 3, 3, 3),
                                                    fontSize: 18,
                                                  ),
                                                )
                                              : Container(
                                                  height: 100,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: NetworkImage(list[index]['content']),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 20,),
                                    Text(list[index]['dateTime'].toString().substring(10,16),style: TimeTextStyle(),),
                                    
                                  ],
                                ),
                            ],
                          );
                    
                        },
                        );
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error);
                    } else {
                      return Center(
                        child: Text("Chat responsibly ",style: GoogleFonts.orbitron(
                          fontSize: 15,fontWeight: FontWeight.w700,color: Colors.grey
                        ),),
                      );
                    }
                  },
                    
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _content,
                   decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // IconButton(onPressed: (){
                            // _imagePickerDialog(context);
                          // }, icon: const Icon(Icons.photo_outlined)),
                          IconButton(onPressed: (){
                            Map<String,dynamic> data = {
                            "senderId" : user?.uid,
                            "avatar" : user?.photoURL ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                            "content_type" : "text",
                            "content" : _content.text.trim(),
                            "dateTime" : DateTime.now().toIso8601String()
                        };
                            sendMessage(context,data);
                          }, icon: const Icon(Icons.send)),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                   ),
                ),
              )
          ],
        ),
      ),
    );
  }

//    Future<void> _imagePickerDialog(BuildContext context) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible:true,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content:  SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               BlocBuilder<ImagePickerBloc, ImagePickerState>(
//                 builder: (context, state) {
//                   if(state.file==null){
//                         return InkWell(
//                           onTap: () {
//                             context.read<ImagePickerBloc>().add(GalleryPicker());
//                             newImge = state.file;
                            
//                           },
//                           child: const CircleAvatar(child:  Icon(Icons.add_a_photo),),
//                         );
//                       }
//                       else{
//                         return Column(
//                           children: [
//                             GestureDetector(
//                                     onTap: () {
//                                       context.read<ImagePickerBloc>().add(GalleryPicker());
//                                       newImge = state.file;
//                                     },
//                                     child: CircleAvatar(
//                                          radius: 60,
//                                       backgroundImage: FileImage(File(state.file!.path.toString()))
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20,),
//                             IconButton(onPressed: (){
//                               sendImage(state.file!.path);
//                             }, icon: const Icon(Icons.send))
//                           ],
//                         );
//                       }
//                 },
//               )
//             ],
//           ),
//         ),
//         // actions: <Widget>[
//         //   IconButton(onPressed: (){}, icon: Icon(Icons.send))
//         // ],
//       );
//     },
//   );
// }

  TextStyle DateTextStyle() => GoogleFonts.poppins(
    fontSize: 12,fontWeight: FontWeight.w600, color: Colors.grey
  );

  TextStyle TimeTextStyle() {
    return GoogleFonts.poppins(
          fontSize: 10,
        );
  }

void sendImage(String newImg)async{
  File file = File(newImg);
   if (!file.existsSync()) {
    return;
  }

  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("file${FirebaseAuth.instance.currentUser!.uid}");
  firebasestorage.UploadTask uploadTask = ref.putFile(file);
  try{
    await uploadTask;
    var downloadUrl = await ref.getDownloadURL();
    Map<String,dynamic> data = {
                          "senderId" :FirebaseAuth.instance.currentUser!.uid,
                          "avatar" : FirebaseAuth.instance.currentUser!.photoURL ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                          "content_type" : "photo",
                          "content" : downloadUrl,
                          "dateTime" : DateTime.now().toIso8601String()
                      };
       databaseReference.child(widget.booking_id).push().set(data).whenComplete((){
      _content.clear();
}) ;
  }
  on FirebaseException catch(e){
    debugPrint(e.message);
  }
}

    void sendMessage(BuildContext context,Map<String,dynamic> data) {
      databaseReference.child(widget.booking_id).push().set(data).whenComplete((){
      _content.clear();
}) ;
  }
}