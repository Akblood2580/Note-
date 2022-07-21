import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:note_app/deliveryboy.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({Key? key}) : super(key: key);

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  Future<Position> getCurrentPositioned() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double? lati;
  double? logng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryBoy(),
                    ));
              },
              icon: Icon(Icons.arrow_forward))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    getCurrentPositioned().then((value) {
                      setState(() {
                        lati = value.latitude;
                        logng = value.longitude;
                      });
                      print("my location");
                      print(lati);
                      print(logng);
                      MapsLauncher.launchCoordinates(
                          value.latitude, value.longitude);
                    });
                  },
                  child: Text("curent location"))),
          SizedBox(
            height: 10,
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {}, child: Text("another location")))
        ],
      ),
    );
  }
}
