import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:note_app/map.dart';

class LocationDetails extends StatefulWidget {
  Map<String, dynamic>? locationdetails;

  LocationDetails({this.locationdetails, Key? key}) : super(key: key);

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      final marker = Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId(widget.locationdetails!['name']),
        position: LatLng(
            widget.locationdetails!['lat'], widget.locationdetails!['lng']),
        infoWindow: InfoWindow(
            title: widget.locationdetails!['name'],
            snippet: widget.locationdetails!['address'],
            onTap: () {
              print(
                  "${widget.locationdetails!['lat']}, ${widget.locationdetails!['lng']}");
            }),
        onTap: () {
          print("Clicked on marker");
        },
      );
      print(
          "${widget.locationdetails!['lat']}, ${widget.locationdetails!['lng']}");
      _markers[widget.locationdetails!['name']] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.locationdetails!["name"]),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _markers.values.toSet(),
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.locationdetails!['lat'],
                      widget.locationdetails!['lng']),
                  zoom: 7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.locationdetails!["image"],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 230,
            right: 10,
            top: 160,
            child: ElevatedButton(
                onPressed: () async {
                  MapsLauncher.launchCoordinates(widget.locationdetails!['lat'],
                      widget.locationdetails!['lng']);
                  
                },
                child: Text(widget.locationdetails!["name"])),
          )
        ],
      ),
    );
  }
}
