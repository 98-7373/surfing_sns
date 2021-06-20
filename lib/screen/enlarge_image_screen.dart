import 'package:flutter/material.dart';
import 'package:surfing_sns/components/hero_image.dart';


class EnlargeImageScreen extends StatelessWidget {
  final Image image;
  EnlargeImageScreen({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: HeroImage(
          onTap: () {
            Navigator.pop(context);
          }
        ),
      ),
    );
  }
}
