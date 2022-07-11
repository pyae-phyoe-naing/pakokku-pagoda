import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/maptype_bloc.dart';
import '../ob/pagoda_ob.dart';
import '../pages/detail.dart';

Widget googleMapWidget(Set<Marker> markers, List<PagodaOb> pagodaList,_completer,_pageController) {
  return BlocBuilder<MaptypeBloc, MapType>(builder: (context, state) {
    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            zoomControlsEnabled: false,
            mapType: state,
            markers: markers,
            initialCameraPosition: const CameraPosition(
              zoom: 13,
              target: LatLng(21.33489, 95.08438),
            ),
            onMapCreated: (controller) {
              _completer.complete(controller);
            },
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 180,
            child: PageView(
              controller: _pageController,
              children: pagodaList
                  .map(
                    (pagoda) => Card(
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Detail(pagodaOb: pagoda))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                pagoda.image![0],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text(pagoda.name!),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(pagoda.location!),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  });
}
