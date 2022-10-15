import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Delete extends StatefulWidget {
  const Delete({super.key});

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('users');

  Future<void> _delete(String productId) async {
    await products.doc(productId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('deleted successfully')));
  }

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
                  leading: Image.network(documentSnapshot['url']),
                  title: Text(documentSnapshot['Name']),
                  subtitle:
                      Text("${documentSnapshot['Price'].toString()}JD/KG"),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.purple,
                            ),
                            onPressed: () => _delete(documentSnapshot.id)),
                      ],
                    ),
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
