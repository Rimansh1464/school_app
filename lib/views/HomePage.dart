import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../helper/colud_firebase_helper.dart';
import '../provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  addData(){
    if(Provider.of<schoolProvider>(context,listen: false).school == true){
      print("kdjfhegtrhkefj..");

      CloudFireStoreHelper.cloudFireStoreHelper.callJson();
    }
    else{
      print("all ready data inseted..");
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController scaleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController staff_quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDilog();
      },child: Icon(Icons.add),backgroundColor: Colors.redAccent),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("School App"),
        backgroundColor: Colors.redAccent,

      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: CloudFireStoreHelper.cloudFireStoreHelper.fetchData(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                  else if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data!;
                    List<QueryDocumentSnapshot> queryDocumentSnapshot =
                        querySnapshot.docs;
                    return ListView.builder(
                      itemCount: queryDocumentSnapshot.length,
                      itemBuilder: (context, i) {
                        Map<String, dynamic> data = queryDocumentSnapshot[i].data() as Map<String, dynamic>;

                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(i: i),));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(blurRadius: 5, color: Colors.black12)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${data['name']}",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      Spacer(),


                                    ],
                                  ),
                                  const Divider(
                                    height: 30,
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
showDilog() {
  showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context,
            void Function(void Function()) setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add School",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //labelText: "name",
                        hintText: " name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: typeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: "price",
                        hintText: " type"),
                  ),const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: capacityController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: "price",
                        hintText: " capacity"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: scaleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: "price",
                        hintText: " scale"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: "price",
                        hintText: " location"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: staff_quantityController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: "price",
                        hintText: " staff quantity"),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {


                    await CloudFireStoreHelper.cloudFireStoreHelper
                        .insertData(
                        name: nameController.text,
                        type: typeController.text,
                        capacity: capacityController.text,
                      scale: scaleController.text,
                      location: locationController.text,
                      staff_quantity: staff_quantityController.text,
                    );

                  nameController.clear();
                  typeController.clear();
                    capacityController.clear();
                    scaleController.clear();
                    locationController.clear();
                    staff_quantityController.clear();

                  Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("redord add seccsefully..")));

                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("save"),
              ),
              OutlinedButton(
                onPressed: () {
                  nameController.clear();
                  typeController.clear();
                  capacityController.clear();
                  scaleController.clear();
                  locationController.clear();
                  staff_quantityController.clear();
                   Navigator.pop(context);
                },
                child: const Text("cancel"),
              ),
            ],
          );
        },
      ));
}
}
