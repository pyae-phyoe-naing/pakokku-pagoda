import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pakokku_pagoda/bloc/maptype_bloc.dart';
import 'package:pakokku_pagoda/bloc/pagoda_bloc.dart';
import 'package:pakokku_pagoda/ob/pagoda_ob.dart';
import 'package:pakokku_pagoda/pages/detail.dart';

import '../widget/googlemap.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<PagodaOb> pagodaList;
  final PageController _pageController = PageController(viewportFraction: .8);
  final Completer<GoogleMapController> _completer = Completer();
  late BitmapDescriptor myIcon;
  @override
  void initState() {
    super.initState();

    // Google Marker Icon
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/images/pagoda.png')
        .then((onValue) {
      myIcon = onValue;
    });
    // PageView 
    _pageController.addListener(() async {
      int pageNo = _pageController.page!.floor().toInt();
      GoogleMapController controller = await _completer.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 18,
            target: LatLng(pagodaList[pageNo].lat!, pagodaList[pageNo].log!),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    PagodaBloc _bloc = BlocProvider.of<PagodaBloc>(context);
    MaptypeBloc _mapTypeBloc = BlocProvider.of<MaptypeBloc>(context);
    _bloc.add(GetDataEvent());
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.blueGrey,
        title: const Text('Pakokku Pagoda'),
        actions: [
          IconButton(
              onPressed: () {
                _mapTypeBloc.add(ChangeMapType());
              },
              icon:const Icon(Icons.satellite_alt))
        ],
      ),
      body: BlocBuilder<PagodaBloc, PagodaState>(
        builder: (context, state) {
          if (state is SuccessState) {
            pagodaList = state.pagodaOb;
            Set<Marker> markers = {};
            pagodaList.forEach((PagodaOb pOb) async {
              markers.add(
                Marker(
                  icon: myIcon,
                  markerId: MarkerId(pOb.id!),
                  infoWindow:
                      InfoWindow(title: pOb.name, snippet: pOb.location),
                  position: LatLng(pOb.lat!, pOb.log!),
                ),
              );
            });

            return googleMapWidget(markers, pagodaList,_completer,_pageController);
          } else if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FailState) {
            return Center(
              child: ElevatedButton(
                  onPressed: () => _bloc.add(GetDataEvent()),
                  child: Text('Refresh')),
            );
          }
          return Container();
        },
      ),
    );
  }

  
}
