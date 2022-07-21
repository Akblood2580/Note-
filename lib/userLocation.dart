import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Userlocation extends StatefulWidget {
  const Userlocation({Key? key}) : super(key: key);

  @override
  State<Userlocation> createState() => _UserlocationState();
}

class _UserlocationState extends State<Userlocation> {
  Future<Position> getCurrentPositioned() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    print("move");
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    getCurrentPositioned().then((value) {
                      print("my location");
                      print(
                        value.latitude.toString(),
                      );
                      print(value.longitude.toString());
                      MapsLauncher.launchCoordinates(
                          value.latitude, value.longitude);
                    });
                  },
                  child: Text("Userlocation")))
        ],
      ),
    );
  }
}
