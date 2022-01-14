import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Fetch extends StatefulWidget {
  const Fetch({ Key? key }) : super(key: key);

  @override
  _FetchState createState() => _FetchState();
}
class _FetchState extends State<Fetch> {
      get()async{
        http.Response response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
       var  jsondata= await jsonDecode(response.body);
       return jsondata;
        }  
 
        

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar:  AppBar(title: Text("Pagination"),centerTitle: true,),
      body: FutureBuilder(future: get(),
      builder: (BuildContext  context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return ListView.builder(itemCount: snapshot.data.toString().length,
          itemBuilder: (context,index){
            return Card(elevation: 10,
              child: 
            ListTile(leading: CircleAvatar(child: Text("${snapshot.data[index]["albumId"]}"),),
              title: Text("${snapshot.data[index]["title"]}"),
              subtitle: Text("${snapshot.data[index]["url"]}"),),);
          },);
        }
        return Text("data");
      },)
    );
  }
}


