import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jaldindi/Widgets/show_suggestions_widget.dart';

class ShowSuggestions extends StatelessWidget {
  const ShowSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Suggestions",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("Suggestion")
            .orderBy("Date And Time", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return SuggestionWidget(
                    name: snapshot.data!.docs[index].get("name"),
                    mob: snapshot.data!.docs[index].get("Mobile"),
                    suggestion: snapshot.data!.docs[index].get("Suggestion"),
                    dateAndTime:
                        snapshot.data!.docs[index].get("Date And Time"),
                  );
                });
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
