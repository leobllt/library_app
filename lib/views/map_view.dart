import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:library_app/models/library.dart';
import 'package:library_app/repositories/local_library.repository.dart';
import 'package:library_app/widgets/library_details.dart';

final appKey = GlobalKey();

// View com demais opções disponíveis para o usuário logado
class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

// View para exibição do mapa
class _MapViewState extends State<MapView>{
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  Future<void> _getCurrentLocation() async {
    // Solicita permissão de localização
    LocationPermission permission = await Geolocator.requestPermission();
    
    // Obtém a localização atual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'Você está aqui'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      // Adiciona marcadores para as unidades da biblioteca
      _addLibraryMarkers();
    });
  }

  void _addLibraryMarkers() { 
    for (Library lib in LocalLibrary.lista) {
      _markers.add(
        Marker(
          markerId: MarkerId(lib.localizacao.toString()),
          position: lib.localizacao,
          onTap: () => {
            showModalBottomSheet(context: appKey.currentState!.context, builder: (context) => LibraryDetails(lib: lib))
          }
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: appKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Unidades'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 14,
              ),
              markers: _markers,
            ),
    );
  }
}

