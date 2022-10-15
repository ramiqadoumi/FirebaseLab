import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('users');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    final String name = nameController.text;
    final String url = urlController.text;

    final double? price = double.tryParse(priceController.text);
    if (price != null) {
      await _products.add({"Name": name, "Price": price, "url": url});

      nameController.text = '';
      priceController.text = '';
      urlController.text = '';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Added Successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Empty field")));
    }

    ;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "Add your new product: ",
          style: TextStyle(
              color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 214, 171, 221)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.purple),
              ),
              focusColor: Colors.purple,
              label: Text(
                "Product Name",
                style: TextStyle(color: Colors.purple),
              ),
              prefixIcon: Icon(
                Icons.add,
                color: Colors.purple,
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple)),
              contentPadding: EdgeInsets.symmetric(horizontal: 2),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25, bottom: 25),
          child: TextField(
            controller: priceController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 214, 171, 221)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.purple),
              ),
              label: Text(
                "Product Price",
                style: TextStyle(color: Colors.purple),
              ),
              prefixIcon:
                  Icon(Icons.price_change_outlined, color: Colors.purple),
              contentPadding: EdgeInsets.symmetric(horizontal: 2),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25, bottom: 25),
          child: TextField(
            controller: urlController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 214, 171, 221)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.purple),
              ),
              label: Text(
                "URL",
                style: TextStyle(color: Colors.purple),
              ),
              prefixIcon: Icon(Icons.now_wallpaper_sharp, color: Colors.purple),
              contentPadding: EdgeInsets.symmetric(horizontal: 2),
            ),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15), backgroundColor: Colors.purple),
            onPressed: () {
              _create();
            },
            child: Text("Add"))
      ]),
    );
  }
}
