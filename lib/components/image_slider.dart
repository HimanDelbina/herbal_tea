import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sara_plant/model/new/herbaltea_model.dart';

import '../static/helper.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
      height: myHeight * 0.2,
      width: myWidth,
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0)),
      child: CarouselSlider(
        items: [
          Image.asset("assets/image/1.png"),
          Image.asset("assets/image/2.png"),
          Image.asset("assets/image/3.png"),
        ],
        options: CarouselOptions(
          // pageSnapping: false,
          height: 400,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          // onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ),

        // itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        //     Container(
        //   child: Text(itemIndex.toString()),
        // ),
      ),
    );
  }
}

class ImageSliderHerbalTea extends StatefulWidget {
  List<ImageHerbaltea>? data;
  ImageSliderHerbalTea({Key? key, this.data}) : super(key: key);

  @override
  State<ImageSliderHerbalTea> createState() => _ImageSliderHerbalTeaState();
}

class _ImageSliderHerbalTeaState extends State<ImageSliderHerbalTea> {
  List<String> imgList = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.data!.length; i++) {
      setState(() {
        imgList.add(Helper.imageUrl + widget.data![i].image.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return CarouselSlider(
        options: CarouselOptions(
            height: myHeight,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true),
        items: imgList
            .map((item) =>
                Image.network(item, fit: BoxFit.cover, height: myHeight))
            .toList());
  }
}
