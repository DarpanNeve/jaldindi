import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jaldindi/screens/Event/upload_data.dart';
import '../Admin/admin.dart';
import '../../Widgets/post_item_widget.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAdmin?FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadEventData(title: 'Event',),
            ),
          );
        },
        label: const Text("Upload Event"),
        icon: const Icon(Icons.add),
      ):null,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
        FirebaseFirestore.instance.collection("Event Upload").orderBy("timestamp",descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                final imageUrl = doc.get("file location");
                if(imageUrl!=null || imageUrl!=""){
                  return PostItem(
                    imageUrl: snapshot.data!.docs[index].get("file location"),
                    title: snapshot.data!.docs[index].get("title"),
                    description:snapshot.data!.docs[index].get("message"),
                  );
                }
                else{
                  return PostItem(
                    //imageUrl: snapshot.data!.docs[index].get("file location"),
                    title: snapshot.data!.docs[index].get("title"),
                    description:snapshot.data!.docs[index].get("message"),
                  );
                }

              },
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
