import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jaldindi/Widgets/image_full_screen.dart';


class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    this.imageUrl,
    required this.title,
    this.description,
  });

  final String? imageUrl;
  final String? description;
  final String title;

  @override
  State<PostItem> createState() => _EItemState();
}

class _EItemState extends State<PostItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    _isExpanded = !_isExpanded;
                  },
                );
              },
              onLongPress: (){
                if (widget.imageUrl != null && widget.imageUrl != "") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageFullScreen(
                          image: widget.imageUrl!),
                    ),
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.imageUrl != null && widget.imageUrl != "")
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              11), // Customize the border radius as needed.
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Hero(
                            tag: "image",
                            child: CachedNetworkImage(
                              imageUrl: widget.imageUrl!,
                              fit: BoxFit.cover,
                              width: 200,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => SizedBox(
                                      height: 300,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      )),
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  if (_isExpanded && widget.description != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.description!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  if (!_isExpanded &&
                      widget.description != null &&
                      widget.description != "")
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
