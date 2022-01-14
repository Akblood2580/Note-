import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:note_app/chat.dart';
import 'package:note_app/des.dart';
import 'package:note_app/signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
class LOgin extends StatefulWidget {
  const LOgin({ Key? key }) : super(key: key);

  @override
  _LOginState createState() => _LOginState();
}
  class _LOginState extends State<LOgin> {
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  TextEditingController user=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  TextEditingController confirm=TextEditingController();
  final formkey=GlobalKey<FormState>();
   void check(){
     try{
            if(auth.currentUser!.uid.isEmpty){
              Navigator.pop(context);
            }else{Navigator.push(context, MaterialPageRoute(builder: (context) => Des(),));}
      }catch(e){print(e);}
    }
    @override
    void initState() {
      check();
      super.initState();
      
    }



   facebook()async{
     try{
        final res=await FacebookAuth.i.login(permissions: ['public_profile','email']);
       if(res.status==LoginStatus.success){
      final  data = FacebookAuth.i.getUserData();
      print(data);
       }
     }catch(e){
       print(e);
     }
   }



     googlesig()async{
      final GoogleSignInAccount? googleSignInAccount= await GoogleSignIn().signIn();
     if(googleSignInAccount!=null){
       GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;
      OAuthCredential credential=GoogleAuthProvider.credential(idToken:googleSignInAuthentication.idToken ,
       accessToken: googleSignInAuthentication.accessToken);
       return await auth.signInWithCredential(credential);

     }
    }
     RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

      valid(){
       if(formkey.currentState!.validate()){
         print("validate");
       }else{print("not validate");}
     }   
  
  up()async{
    try{
    UserCredential userCredential= await auth.createUserWithEmailAndPassword(email: email.text, password:pass.text);
      var unique =await auth.currentUser!.uid;
      firebaseFirestore.collection("user").doc(unique).set({"user":user.text,"email":email.text,"password":pass.text,"confirmation password":confirm.text});
      user.clear();email.clear();pass.clear();confirm.clear();
      if(unique.isNotEmpty){
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signin(),));
      }
  }on FirebaseAuthException catch(e){
    if(e.code=="email id already in used by a another account"){
      return Text("email id already used");
    }
  }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(scrollDirection: Axis.vertical,reverse: true,
         child: Container(height: MediaQuery.of(context).size.height,
           decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purpleAccent,Colors.blue])),
           padding:EdgeInsetsDirectional.fromSTEB(10, 5, 15, 0),
          child: Column(children: [Image.asset("assest/image/signin.png",width: 200,height: 200,),
            Text("SIGNUP",style:GoogleFonts.poppins(fontSize: 30,color: Colors.white),),
            Form(key: formkey,
            child: Column(
          children: [TextFormField(autofocus: true,
            controller: user,validator: (value){
            if(!value!.contains(RegExp(r'[A-Z]'),)){
               return "user name should be in capital letter";
            }else{
              if(value.isEmpty){
                   return "please enter a user name";
              }else {return null;}
            }
          },
            decoration: InputDecoration(prefixIcon: Icon(Icons.person,color: Colors.black,),
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(20)),
              labelText: "Username",labelStyle: TextStyle(color: Colors.white)),autocorrect: true,autovalidateMode: AutovalidateMode.onUserInteraction,),SizedBox(height: 10,),
          TextFormField(autofocus: true,
            validator: (value){
            if(!value!.contains("@gmail.com")){
               return "please mention @gmail.com";
            }
            else{if(value.isEmpty){
              return "emailid should not be empty";
            }else{
              return null;
            }
            }
          },
            controller: email,
            decoration: InputDecoration(prefixIcon: Icon(Icons.email,color: Colors.black,),hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(20)),
              labelText: "emailid",labelStyle: TextStyle(color: Colors.white)),autocorrect: true,autovalidateMode: AutovalidateMode.onUserInteraction,),SizedBox(height: 10,),
          TextFormField(
            autofocus: true,validator: (value){
            if(!regex.hasMatch(value!)){
              return "at least one upper case\n"
              "at least one lower case\n "
              "at least one digit\n"
              "at least one special character";
            }else{return null;}
          },
            controller: pass,
            decoration: InputDecoration(hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.lock,color: Colors.black,),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(20)),
              labelText: "password",labelStyle: TextStyle(color: Colors.white)),
              autocorrect: true,autovalidateMode: AutovalidateMode.onUserInteraction,),SizedBox(height: 10,),
            ],
             )),SizedBox(height: 30,),
             ElevatedButton(style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 15,horizontal: 60),
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
          onPressed: (){valid();up();}, 
          child: Text("signup",style: TextStyle(fontSize: 20),)),SizedBox(height:10,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Already have an account",style: TextStyle(fontSize: 20),),TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => Signin(),));}, child: Text("Signin",style: TextStyle(fontSize: 20,color: Colors.white),)),],),
          SignInButton(Buttons.Google, onPressed: (){googlesig();}),
          SignInButton(Buttons.FacebookNew, onPressed: (){facebook();})],),),
       ),
    );
  
  }
}