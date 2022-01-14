import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:note_app/chat.dart';
import 'package:note_app/signin.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Des extends StatefulWidget {
  const Des({ Key? key }) : super(key: key);

  @override
  _DesState createState() => _DesState();
}
class _DesState extends State<Des> {
var snapshotData;
var searchValue;
FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
TextEditingController title=TextEditingController();
TextEditingController description=TextEditingController();
TextEditingController search=TextEditingController();
var time = DateTime.now().toString();
var titl="";
bool issearching=false;
logout(){
showDialog(context: context, 
builder: (context){
return AlertDialog(title: Text("Are you sure you want to Logout"),
actions: [TextButton(onPressed: (){auth.signOut();Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signin(),));},
 child:Text("Yes")),TextButton(onPressed: (){Navigator.pop(context);}, 
 child:Text("No")),],);
 });
}
 //SharedPreferences 
valse()async{
SharedPreferences share= await SharedPreferences.getInstance();
var sha=share.getString("trig");
return sha;
  }

  talse()async{
    SharedPreferences share= await SharedPreferences.getInstance();
    share.setString("trig",titl);
  }

  checkforvalue()async{
     var value=await valse()??"0";
     setState(() {
       titl=value;
     });
  }
//SharedPreferences



  void updat({til, desc, time, tim}){
    title.text=til;
    description.text=desc;
   
    showDialog(context: context, builder:(context){
         return SingleChildScrollView(
           scrollDirection: Axis.vertical,
           reverse: true,
          child: AlertDialog(elevation: 10,
           title: Text("Update your notes"),actions: [Column(children: [TextFormField(autofocus: true,
                                    controller: title,validator: (value){
                     if(value!.isEmpty){
                   return'enter your title';}
              else{return null;}
            },
          decoration: InputDecoration(labelText: "title",
          
            hintStyle: TextStyle(color: Colors.black),
               border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
             borderRadius: BorderRadius.circular(20)),),
               autocorrect: true,
             autovalidateMode: AutovalidateMode.onUserInteraction,
               maxLines: null,),SizedBox(height: 20,),
           TextFormField(controller: description,validator: (value){
              if(value!.isEmpty){
                return 'enter your description';
              }else {return null;}
            },
              decoration: InputDecoration(labelText: "description",hintStyle: TextStyle(color: Colors.black),
              
              
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),
              borderRadius: BorderRadius.circular(20)),),
              autocorrect: true,autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: null,autofocus: true,),Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text("cancel")),TextButton(onPressed: (){save(tim);}, child: Text("Save"))],)],)],scrollable: true,),
         );
         
    });
  }


  save(tim){
    try{
    if(title.text.isNotEmpty && description.text.isNotEmpty){
     return firebaseFirestore.collection("note").doc(auth.currentUser!.uid).collection("time").doc(tim).
     update({"title":title.text,"Description":description.text,}).then((value) => Navigator.pop(context));
  }else{return null;}}catch(e){print(e);}
  }


  khojo(value){
   var updatedsnapShot=snapshotData.where((i){
     print(i['title']);
    return i['title'].contains(value)?true:false;
   }).toList();
   setState(() {
    searchValue=value;
     snapshotData=updatedsnapShot;
   });
  }

  

 
@override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      SystemNavigator.pop();
      return true;
    },
      child: Scaffold(floatingActionButton: FloatingActionButton(onPressed: (){
         Navigator.push(context,MaterialPageRoute(builder: (context) => Chat(),));
      },child:Icon(Icons.add),),
        appBar: AppBar(
                  
          title: !issearching ? Text("Note"):
    
          TextFormField(onChanged: (value){
            if(value.isEmpty)
            { 
              setState(() {
              issearching=false;
               
              });
             }else{
    
            khojo(value);
            
             }},
          validator: (value){
              if(value!.isEmpty)
              {
                setState(() {
                  issearching=false;
                });
              }
          },
    
            showCursor: true,cursorColor:Colors.white,controller: search,
          decoration: InputDecoration(hintText: "search your text",
                hintStyle: TextStyle(color: Colors.black38),
                ))
          ,centerTitle: true,actions: [ !issearching?
            IconButton(onPressed: (){
              setState(() {
            this.issearching=!this.issearching;
          });},
           
            icon: Icon(Icons.search)):IconButton(onPressed: (){setState(() {
            this.issearching=!this.issearching;
            
          });}, icon: Icon(Icons.cancel)),IconButton(onPressed: (){logout();}, icon: Icon(Icons.logout))],),
        body:  StreamBuilder<QuerySnapshot>(stream: firebaseFirestore.collection("note").doc(auth.currentUser!.uid).collection("time").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
           if(snapshot.hasData){
             snapshotData = (!issearching)?snapshot.data!.docs:snapshotData;
    
             return ListView.builder(itemCount:snapshotData.length,
             itemBuilder: (context,index){
               
               return Card(child: InkWell(onTap: (){},
                 child: ListTile(leading: CircleAvatar(child: Text("${snapshotData[index]["title"][0]}${snapshotData[index]["Description"][0]}") ,),
                   title: Text(snapshotData[index]["title"],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                 subtitle:Text(snapshotData[index]["Description"] ,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                 trailing:  Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {updat(til:snapshotData[index]["title"],desc:snapshotData[index]["Description"],tim:snapshotData[index]["Time"]);}, icon: Icon(Icons.edit,color: Colors.black,)),
                IconButton(onPressed: () async{ await firebaseFirestore.collection("note").doc(auth.currentUser!.uid).collection("time").doc(snapshotData[index]["Time"].toString()).delete();}, icon: Icon(Icons.delete,color: Colors.black,)),
                  ],),
                           contentPadding: EdgeInsetsDirectional.all(10),),
               ),elevation: 8,);
             },);
           }
           else{if(!snapshot.hasData){
             return Center(child: CircularProgressIndicator(),);
           }}
           
           return Text("data");
      }
    
      )),
    );
      
  }
}
