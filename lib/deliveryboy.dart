import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DeliveryBoy extends StatefulWidget {
  DeliveryBoy({Key? key}) : super(key: key);

  @override
  State<DeliveryBoy> createState() => _DeliveryBoyState();
}

class _DeliveryBoyState extends State<DeliveryBoy> {
  PolylinePoints polylinePoints = PolylinePoints();

  final Set<Polyline> polylines = {};

  List<LatLng> latlang = [
    LatLng(28.622934, 77.364026),
    LatLng(28.594169, 77.335373)
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   for (int i = 0; i < latlang.length; i++) {
  //     setState(() {});
  //     polylines.add(Polyline(polylineId: PolylineId("1"), points: [
  //       LatLng(28.622934, 77.364026),
  //       LatLng(28.594169, 77.335373)
  //     ]));
  //   }
  // }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (controller) => googleMapController = controller,
            initialCameraPosition:
                CameraPosition(target: LatLng(28.622934, 77.364026))));
  }
}
