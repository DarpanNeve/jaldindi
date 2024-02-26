import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jaldindi/Widgets/loading.dart';
import 'package:jaldindi/Widgets/image_full_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String about='';
  String goal = '';
  String objectives = '';
  String vision = '';
  String mission = '';
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchAboutData();
    fetchImages();
  }

  fetchAboutData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('About').doc('Info').get();
    if (snapshot.exists && mounted){
      setState(() {
        about = snapshot.get('About');
        goal = snapshot.get('GOAL:');
        objectives = snapshot.get('OBJECTIVES:');
        vision = snapshot.get('VISION:');
        mission = snapshot.get('MISSION:');
      });
    }
  }

  fetchImages() async {
    final listResult = await  FirebaseStorage.instance.ref().child("About").listAll();
    for (var item in listResult.items) {
      final url = await item.getDownloadURL();
      if(mounted){
        setState(() {
          imageUrls.add(url);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: imageUrls.isNotEmpty
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width*0.9,
                    child:
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        autoPlay: true,
                       aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index,int pageViewIndex) {
                        return GestureDetector(
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageFullScreen(
                                    image: imageUrls[index]),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: imageUrls[index],
                              fit: BoxFit.cover,
                              width:MediaQuery.of(context).size.width*0.9,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:16.0,left: 16,right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        allText("About", about),
                        allText("Goal", goal),
                        allText("Objective", objectives),
                        allText("Vision", vision),
                        allText("Mission", mission),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Loading(),
    );
  }

  Widget allText(String data, String information) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "$data :",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
          child: Text(
            information,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
