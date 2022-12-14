import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';


List<dynamic> jsondata = [];

class CloudFireStoreHelper {
  CloudFireStoreHelper._();

  static final CloudFireStoreHelper cloudFireStoreHelper =
      CloudFireStoreHelper._();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  callJson() async {
    String jasonDta = await rootBundle.loadString("asserts/json/school.json");
    jsondata = jsonDecode(jasonDta);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('school', true);
    jsondata.forEach((element) async {
      await school.doc().set({
        'name': element['name'],
        'type': element['type'],
        'capacity': element['capacity'],
        'scale': element['scale'],
        'location': element['location'],
        'staff_quantity': element['staff_quantity']
      });
    });
  }

  CollectionReference school = FirebaseFirestore.instance.collection('school');

  //TODO : insertData
  insertData({
    required String name, required String type,required capacity,required scale,required location,required staff_quantity
  }) async {
    await school.doc().set({
      'name': name,
      'type': type,
      'capacity': capacity,
      'scale': scale,
      'location': location,
      'staff_quantity': staff_quantity,
    });
  }

  //TODO : fetchData
  Stream<QuerySnapshot> fetchData() {
    Stream<QuerySnapshot> stream = school.snapshots();

    return stream;
  }

  updateData({ required id,required String name, required String type,required capacity,required scale,required location,required staff_quantity
  }) async {
    await school.doc(id).update({
      'name': name,
      'type': type,
      'capacity': capacity,
      'scale': scale,
      'location': location,
      'staff_quantity': staff_quantity,
    });
  }

//TODO : deleteData
  deleteData({required id}) async {
    await school.doc(id).delete();

  }
}
