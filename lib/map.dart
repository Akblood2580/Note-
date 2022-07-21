import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:note_app/locationDetails.dart';

class GoogleMa extends StatefulWidget {
  const GoogleMa({Key? key}) : super(key: key);

  @override
  State<GoogleMa> createState() => _GoogleMaState();
}

class _GoogleMaState extends State<GoogleMa> {
  final List<Map<String, dynamic>> clityList = const [
    {
      "address": "Jaipur the pink city",
      "id": "jaipur_01",
      "image":
          "https://i.pinimg.com/originals/b7/3a/13/b73a132e165978fa07c6abd2879b47a6.png",
      "lat": 26.922070,
      "lng": 75.778885,
      "name": "Jaipur India",
      "phone": "7014333352",
      "region": "South Asia"
    },
    {
      "address": "New Delhi capital of india",
      "id": "delhi_02",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": 28.644800,
      "lng": 77.216721,
      "name": "Delhi City India",
      "phone": "7014333352",
      "region": "South Asia"
    },
    {
      "address": "Mumbai City",
      "id": "mumbai_03",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/7/7e/Mumbai_Taj.JPG",
      "lat": 19.076090,
      "lng": 72.877426,
      "name": "Mumbai City India",
      "phone": "7014333352",
      "region": "South Asia"
    },
    {
      "address": "Udaipur City",
      "id": "udaipur_04",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/6/6f/Evening_view%2C_City_Palace%2C_Udaipur.jpg",
      "lat": 24.571270,
      "lng": 73.691544,
      "name": "Udaipur City India",
      "phone": "7014333352",
      "region": "South Asia"
    }
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GoogleMap"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                
              },
              icon: Icon(Icons.location_on))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: clityList.length,
                  itemBuilder: (BuildContext context, int) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: (clityList[int]["image"] != null)
                                  ? Image.network(
                                      clityList[int]["image"],
                                      fit: BoxFit.fill,
                                    )
                                  : Center(child: CircularProgressIndicator())),
                        ),
                        Positioned(
                          left: 230,
                          right: 10,
                          top: 160,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LocationDetails(
                                          locationdetails: clityList[int]),
                                    ));
                              },
                              child: Text(clityList[int]["name"])),
                        )
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
