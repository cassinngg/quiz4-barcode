import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogViewPage extends StatefulWidget {
  @override
  _LogViewPageState createState() => _LogViewPageState();
}

class _LogViewPageState extends State<LogViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Log Viewer'),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('Logs').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            // Safely access data and handle potential null values
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = docs[index];
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['logName'] ??
                      'Unknown'), // Provide a fallback value if null
                  subtitle:
                      Text('${data['date']}' ?? 'Unknown'), // Handle null dates
                );
              },
            );
          },
        ));
  }
}
