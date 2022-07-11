import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pakokku_pagoda/data/api.dart';

import '../ob/pagoda_ob.dart';

part 'pagoda_event.dart';
part 'pagoda_state.dart';

class PagodaBloc extends Bloc<PagodaEvent, PagodaState> {
  PagodaBloc() : super(StartState()) {
    on<GetDataEvent>((event, emit) async {
      emit(LoadingState());
      try {
        List<PagodaOb> pagodaList = await Api.getData();
        emit(SuccessState(pagodaList));
      } catch (e) {
        emit(FailState(e.toString()));
      }
    });

  }
}
