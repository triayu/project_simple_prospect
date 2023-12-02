import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/core/app_config.dart';
import 'package:simple_prospect/app/core/text_theme.dart';

class GmapsLocation extends StatefulWidget {
  GmapsLocation({Key? key}) : super(key: key);

  @override
  State<GmapsLocation> createState() => _GmapsLocationState();
}

class _GmapsLocationState extends State<GmapsLocation> {
  // Google Map Controller
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  // Camera Position
  static const CameraPosition _baliIsland = CameraPosition(
    target: LatLng(-8.4095189, 115.188916),
    zoom: 14.4746,
  );
  // Marker
  Set<Marker> markers = {};
  // Global Key Form
  final _homeScaffoldKey = GlobalKey<ScaffoldState>();

  void _onSearchClicked() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppConfig.apiKeyMaps,
      mode: Mode.overlay,
      region: "id",
      radius: 1000000,
      language: "en",
      types: [""],
      onError: onError,
      components: [Component(Component.country, "id")],
      decoration: InputDecoration(
        hintText: 'Cari Lokasi',
      ),
    );
    if (p != null) {
      displayPrediction(p, _homeScaffoldKey.currentState);
    } else {
      logg('null', name: 'Prediction');
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    LzToast.show(response.errorMessage!);

    logg(response.errorMessage);
  }

  void displayPrediction(Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces _places =
        GoogleMapsPlaces(apiKey: AppConfig.apiKeyMaps, apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    logg(detail);
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(detail.result.formattedAddress!),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: detail.result.formattedAddress!,
            snippet: 'This is your event location',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );

      _controller.future.then((controller) {
        controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _homeScaffoldKey,
        body: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: _baliIsland,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (LatLng latLng) {
                logg(latLng);
                // when user tap on the map, we will get lat and long and set marker
                setState(() {
                  markers.clear();
                  markers.add(
                    Marker(
                      markerId: MarkerId(latLng.toString()),
                      position: latLng,
                      infoWindow: InfoWindow(
                        title: 'Event Location',
                        snippet: 'This is your event location',
                      ),
                      icon: BitmapDescriptor.defaultMarker,
                    ),
                  );
                });
              },
              mapToolbarEnabled: false,
              markers: markers,
            ),
            InkTouch(
              onTap: () {
                _onSearchClicked();
              },
              child: Container(
                color: Colors.white.withOpacity(0.8),
                padding: Ei.all(10),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.black.withOpacity(0.5), size: 35).margin(r: 10),
                    Flexible(
                      child: Text(
                        'Klik dsini, untuk mencari lokasi event',
                        maxLines: 2,
                        style: Gfont.autoSizeText(context, FontSizeManager.getSublineFontSize()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: (markers.isNotEmpty)
            ? FloatingActionButton.extended(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  Navigator.pop(context, markers.first.position);
                },
                label: Text('Pilih Lokasi Ini'),
              )
            : None());
  }
}
