import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'carousel_item.dart';

class CarouselSliderItem extends StatefulWidget {
  const CarouselSliderItem({Key? key}) : super(key: key);

  @override
  State<CarouselSliderItem> createState() => _CarouselSliderItemState();
}

class _CarouselSliderItemState extends State<CarouselSliderItem> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return CarouselItem(index: index);
      },
      options: CarouselOptions(
        viewportFraction: 0.88,
        height: 200 * screenHeight,
        // viewportFraction: 1,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 10),
        onPageChanged: (index, reason) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
    );
  }
}
