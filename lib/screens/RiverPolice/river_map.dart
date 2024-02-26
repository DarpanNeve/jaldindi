import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jaldindi/models/map_model.dart';


class RiverMap extends StatefulWidget {
  const RiverMap({super.key});

  @override
  State<RiverMap> createState() => _RiverMapState();
}

class _RiverMapState extends State<RiverMap> {
  final Set<Marker> _markers = {};
  final String allocated=" - ";
  var mapType=MapType.satellite;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      for (final office in MapRepo().mapList) {
        _markers.add(
          Marker(
            markerId: MarkerId(office.locationName),
            position: LatLng(office.latitude, office.longitude),
            infoWindow: InfoWindow(
              title: office.locationName,
              snippet: "${office.ghatName}$allocated${office.collegeName}",

            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('River Map'),
        elevation: 2,
      ),
      floatingActionButton: Padding(
        padding:const EdgeInsets.only(top: 100),
        child: FloatingActionButton(
          onPressed: (){
              setState(() {
              if(mapType==MapType.satellite){
                mapType=MapType.normal;
              }else{
                mapType=MapType.satellite;
              }
            });
          },

          child:const Icon(Icons.map),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(MapRepo().mapList[11].latitude, MapRepo().mapList[11].longitude),
          zoom: 10,

        ),
        mapType: mapType,
        markers: _markers,
      ),
    );
  }
}