import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselab/screens/Add.dart';
import 'package:firebaselab/screens/Show.dart';
import 'package:firebaselab/screens/Update.dart';
import 'package:firebaselab/screens/delete.dart';
import 'package:firebaselab/screens/loginpage.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 225, 116, 245),
                ),
                accountName: Text("Rami Ibrahim"),
                accountEmail: Text("rami@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    "R",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  var auth = FirebaseAuth.instance;

                  auth.signOut().then((value) => Navigator.of(context)
                      .pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => loginPage()),
                          (route) => false));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text("Home page"),
          bottom: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "Show all prodects",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Add new prodects",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Update prodects",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Delete prodects",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
        ),
        body: const TabBarView(children: [
          //"Show all prodects",
          Show(),
          //"Add new prodects",
          Add(),
          //"Update prodects",
          Update(),
          //delete
          Delete()
        ]),
      ),
    );
  }
}
