import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'maptype_event.dart';
part 'maptype_state.dart';

class MaptypeBloc extends Bloc<MaptypeEvent, MapType> {
  MaptypeBloc() : super(MapType.normal) {
    on<ChangeMapType>((event, emit) {

      if (state == MapType.normal) {
        emit(MapType.hybrid);
      } else if (state == MapType.hybrid) {
        emit(MapType.normal);
      }
    });
  }
}
