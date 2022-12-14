import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/colud_firebase_helper.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, required this.i}) : super(key: key);
  late int i;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController scaleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController staff_quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: CloudFireStoreHelper.cloudFireStoreHelper.fetchData(),
                builder: (context, snapshot) {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<QueryDocumentSnapshot> queryDocumentSnapshot =
                      querySnapshot.docs;
                  Map<String, dynamic> data = queryDocumentSnapshot[widget.i]
                      .data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
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
                              Text(
                                "School : ${data['name']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              const Divider(
                                height: 30,
                                thickness: 2,
                                color: Colors.black,
                              ),
                              Text(
                                "type: ${data['type']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "capacity: ${data['capacity']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "scale:  ${data['scale']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "location: ${data['location']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "staff_quantity:  ${data['staff_quantity']}",
                                style: TextStyle(fontSize: 20),
                              ),

                              // "${data['name']}",
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 400,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap:(){
                              nameController.text = data['name'];
                              typeController.text = data['type'];
                              capacityController.text = data['capacity'];
                              scaleController.text = data['scale'];
                              locationController.text = data['location'];
                              staff_quantityController.text = data['staff_quantity'];
                              updateDialog(id: queryDocumentSnapshot[widget.i].id);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("redord update seccsefully..")));

                            },
                            child: Container(width: 130,
                                height: 50,

                                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                    child: Text(
                                  "edit",
                                  style: TextStyle(color: Colors.white),
                                ))),
                          ),
                          InkWell(
                            onTap:(){
                              CloudFireStoreHelper.cloudFireStoreHelper
                                  .deleteData(id: queryDocumentSnapshot[widget.i].id);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("redord deletion seccsefully..")));
                            },
                            child: Container(
                              width: 130,
                                height: 50,

                                decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                    child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ))),
                          ),
                        ],
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  updateDialog({required id}) {
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
                        "Update Product",
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
                              hintText: "name"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: typeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: "price",
                              hintText: "type"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: capacityController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: "price",
                              hintText: "capacity"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: scaleController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: "price",
                              hintText: "scale"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: locationController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: "price",
                              hintText: "lacation"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: staff_quantityController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: "price",
                              hintText: "Product price"),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        await CloudFireStoreHelper.cloudFireStoreHelper
                            .updateData(
                          id:id,
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
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text("Update"),
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
