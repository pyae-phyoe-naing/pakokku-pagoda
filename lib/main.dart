import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakokku_pagoda/bloc/maptype_bloc.dart';
import 'package:pakokku_pagoda/bloc/pagoda_bloc.dart';
import 'package:pakokku_pagoda/pages/home.dart';

import 'data/api.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(brightness: Brightness.light),
      home:BlocProvider(
        create: (context) => MaptypeBloc(),
        child: BlocProvider(
          create: (context) => PagodaBloc(),
          child:const Home(),
        ),
      ),
    );
  }
}
