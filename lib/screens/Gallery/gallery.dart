import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jaldindi/screens/Event/upload_data.dart';
import '../Admin/admin.dart';
import '../../Widgets/post_item_widget.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAdmin?FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadEventData(title: 'Gallery',),
            ),
          );
        },
        label: const Text("Upload Image"),
        icon: const Icon(Icons.add),
      ):null,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
              FirebaseFirestore.instance.collection("Gallery Upload").orderBy("timestamp",descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return PostItem(
                  imageUrl: snapshot.data!.docs[index].get("file location"),
                  title: snapshot.data!.docs[index].get("title"),
                  description:snapshot.data!.docs[index].get("message"),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
