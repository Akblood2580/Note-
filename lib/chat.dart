// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/des.dart';
import 'package:note_app/signin.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  const Chat({ Key? key, title, description }) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  final  formkey=GlobalKey<FormState>();

  val(){
     if(formkey.currentState!.validate()){
       return"validate";
     }else{return "not validate";}
   }

  var time =DateTime.now();

   show()
   {var unique =  auth.currentUser!.uid;
           firebaseFirestore.collection("note").doc(unique).collection("time").doc(time.toString()).
             set({"title":title.text,"Description":description.text,"Time":time.toString()}).whenComplete(() => print("successfully save"));
               Navigator.push(context,MaterialPageRoute(builder: (context) => Des(),));
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Note"),
    centerTitle: true,),
        body: SingleChildScrollView(
          child: Container(padding:EdgeInsetsDirectional.fromSTEB(15, 80, 15, 0),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purpleAccent,Colors.blue])),
                 child: Column(children: [Form(key: formkey,
                    child: Column(
                       children: [
                            TextFormField(autofocus: true,
                              controller: title,validator: (value){
                   if(value!.isEmpty){
                 return'enter your title';}
            else{return null;}
          },
 decoration: InputDecoration(labelText: "title",labelStyle: TextStyle(color: Colors.white),
   hintStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(20)),),
      autocorrect: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: null,),SizedBox(height: 10,),

        TextFormField(controller: description,validator: (value){
            if(value!.isEmpty){
              return 'enter your description';
            }else {return null;}
          },
            decoration: InputDecoration(labelText: "description",labelStyle: TextStyle(color: Colors.white),
            
            
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),
            borderRadius: BorderRadius.circular(20)),),
            autocorrect: true,autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: null,autofocus: true,)],
              )),SizedBox(height: 15,),
              ElevatedButton(style: ElevatedButton.styleFrom(
           primary: Colors.teal,
           onPrimary: Colors.white,
           onSurface: Colors.grey,
            
            padding: EdgeInsets.symmetric(
              vertical: 15,horizontal: 60),
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
            onPressed: (){val(); show();}, 
            
            child: Text("save",style: TextStyle(fontSize: 20),)),
              ],),),
        ),
    );
  }
  
}




        
        
        