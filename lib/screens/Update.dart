import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final CollectionReference products =
      FirebaseFirestore.instance.collection('users');
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      nameController.text = documentSnapshot['Name'];
      priceController.text = documentSnapshot['Price'].toString();
      urlController.text = documentSnapshot['url'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text(
                        "Name",
                        style: TextStyle(color: Colors.purple),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 214, 171, 221)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ),
                    ),
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text(
                        "Price",
                        style: TextStyle(color: Colors.purple),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 214, 171, 221)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: priceController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: urlController,
                    decoration: InputDecoration(
                      label: Text(
                        "URL",
                        style: TextStyle(color: Colors.purple),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 214, 171, 221)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      backgroundColor: Colors.purple),
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = nameController.text;
                    final String url = urlController.text;
                    final double? price = double.tryParse(priceController.text);
                    if (price != null) {
                      await products
                          .doc(documentSnapshot!.id)
                          .update({"Name": name, "Price": price, "url": url});
                      nameController.text = '';
                      priceController.text = '';
                      urlController.text = '';
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("updated successfully")));
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink.shade50,
      child: StreamBuilder(
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
                        child: Row(children: [
                          IconButton(
                              icon: const Icon(Icons.mode_edit_outline_outlined,
                                  color: Colors.purple),
                              onPressed: () => _update(documentSnapshot)),
                        ]),
                      ),
                    ));
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        },
      ),
    );
  }
}
