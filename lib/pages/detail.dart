import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pakokku_pagoda/ob/pagoda_ob.dart';

class Detail extends StatelessWidget {
  final PagodaOb pagodaOb;
  Detail({required this.pagodaOb, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,

        title: Text(pagodaOb.name!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Location'),
              subtitle: Text(pagodaOb.location!),
            ),
            Divider(color: Colors.grey,),
            Text('အကြောင်းအရာ -',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 20),),
            Text(pagodaOb.about!),
              Divider(color: Colors.grey,),
              Column(
                children: pagodaOb.image!.map((e) => Image.network(e,height: 300,)).toList(),
              )
          ],
        ),
      ),
    );
  }
}
