import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocode/geocode.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {

  Location location = new Location();
  GeoCode geoCode = GeoCode();
  Address? address;

  CameraPosition haibowal = CameraPosition(
    target: LatLng(30.9251984, 75.8073307),
    zoom: 16,
  );

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  checkPermissionAndFetchLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    print("Fetching Location");
    _locationData = await location.getLocation();
    print('Location Fetched');

    print("Fetching Address..");
    address = await geoCode.reverseGeocoding(latitude: _locationData!.latitude as double, longitude: _locationData!.longitude as double);
    print('Address Fetched');
    print("Address: $address");


    setState(() {
      haibowal = CameraPosition(
        target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
        zoom: 20,
      );
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {

    checkPermissionAndFetchLocation();

    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps Page"),
      ),
      body: GoogleMap(
        initialCameraPosition: haibowal,
        mapType: MapType.normal,
        trafficEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId("atpl"),
            position: LatLng(30.9251984, 75.8073307),
            onTap: (){},
            infoWindow: InfoWindow(
              title: address!.streetAddress.toString(),
              snippet: address!.countryName.toString(),
              onTap: (){},
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          ),
        },
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
