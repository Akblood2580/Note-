import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:note_app/chat.dart';
import 'package:note_app/login.dart';
class Signin extends StatefulWidget {
  const Signin({ Key? key }) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  TextEditingController mail=TextEditingController();
  TextEditingController pas=TextEditingController();
   final formkey=GlobalKey<FormState>();
   TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  sahi(){
    if(formkey.currentState!.validate()){
      print("validate");
    }else{print("not validate");}
  }

   sig()async{
     try{
     auth.signInWithEmailAndPassword(email: mail.text, password: pas.text);
     if(auth.currentUser!.uid!=null){
    return Navigator.push(context,MaterialPageRoute(builder: (context) => Chat(),));
     }
     }on FirebaseAuthException catch(e){
       if(e.code=="invalid-email"){
         print("invalid email-id");
       }
       else{if(e.code=="user not found"){
         print("No user found for that email");

       }else{if(e.code=="wrong password"){
         print("wrong password");
       }} 
       }
     }
   }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      SystemNavigator.pop();
      return true;
    },
      child: Scaffold(
         body: SingleChildScrollView(
           child: Container(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               gradient: LinearGradient(begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purpleAccent,Colors.blue])),
             padding:EdgeInsetsDirectional.fromSTEB(15, 80, 15, 0),
            child: Column(
            children: [Image.asset("assest/image/signin.png",
            width: 200,
            height: 200,),
              Text("SIGNIN",
              style: TextStyle(color: Colors.white,
              fontSize: 20),),SizedBox(height: 1.5,),
            Text("TO CONTINUE",style: TextStyle(
              color: Colors.white,fontSize: 20),),SizedBox(height: 30,),
            Form(key: formkey,
              child: Column(
            children: [
            TextFormField(autofocus: true,
            autocorrect: true,
            controller: mail,validator: (value){
              if(value==email.text){
                 return null;
              }else {if(value!=email.text){
                return "email does not match";
              }}
            },
              decoration: InputDecoration(labelText: "EmailId",labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.email,color: Colors.black,),
              prefixIconColor: Colors.white,
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(20)),)),
              SizedBox(height: 15,),
              TextFormField(autofocus: true,
              autocorrect: true,
              controller: pas,
    
              validator: (value){
              if(value!=pass.text){
                return "password is incorrect";
              }else{if(value==pass.text){
                return null;
              }}
            },
              decoration: InputDecoration(prefixIcon: Icon(Icons.lock,color: Colors.black,),
              
                labelText: "password",labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(20)),),)],
               )),SizedBox(height: 20,),
               ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 60),
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
            onPressed: (){sahi(); sig();},
             child: Text("signin",
             style: TextStyle(color: Colors.black),)),],),),
         ),
      ),
    );
  
  }
}