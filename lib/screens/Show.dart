// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Show extends StatefulWidget {
  const Show({super.key});

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: products.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Card(
                color: Color.fromARGB(255, 225, 116, 245),
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  leading: Image.network(
                    documentSnapshot['url'],
                    width: 70,
                    height: 70,
                  ),
                  title: Text(documentSnapshot['Name']),
                  subtitle:
                      Text("${documentSnapshot['Price'].toString()}JD/KG"),
                  trailing: SizedBox(
                    width: 80,
                  ),
                ),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        );
      },
    );
  }
}
