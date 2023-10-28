import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class CarouselItem extends StatelessWidget {
  final int index;
  const CarouselItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index == 0)
          Container(
            height: screenHeight * 150,
            width: screenWidth * 310,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffEEFFF2),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 20.0, top: screenHeight * 15),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: screenHeight * 15),
                      Text(
                        '25% OFF',
                        style: TextStyle(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: screenHeight * 6),
                      Text(
                        'On the first cleaning service',
                        style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: screenHeight * 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 41 * screenHeight,
                          width: screenWidth * 134,
                          decoration: BoxDecoration(
                            color: Color(0xff48C945),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.eh,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/icons/repair_illustration.svg',
                    height: 90 * screenHeight,
                    width: 94 * screenWidth,
                    // fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        if (index == 1)
          Container(
            height: screenHeight * 170,
            width: screenWidth * 310,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffEEFBFF),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 23.0,
                  top: screenHeight * 20,
                  right: 30 * screenWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Repairing',
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8 * screenWidth),
                      Image.asset('assets/icons/5-Star.png'),
                    ],
                  ),
                  SizedBox(height: 6 * screenHeight),
                  SizedBox(
                    width: 207 * screenWidth,
                    child: Text(
                      'We offer professional repairing service on-demand!',
                      style: TextStyle(
                        height: 1.3,
                        color: Color(0xffd2d2d2),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 6 * screenHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$' + '45' + '/hr',
                        style: TextStyle(
                          color: Color(0xff0c46b6),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text('Read More!',
                            style: TextStyle(
                              color: Color(0xff0c46b6),
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        if (index == 2)
          Container(
            height: screenHeight * 170,
            width: screenWidth * 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffEEFBFF),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 23.0,
                  top: screenHeight * 20,
                  right: 30 * screenWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Plumbering',
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 13 * screenWidth),
                      Image.asset('assets/icons/5-Star.png'),
                    ],
                  ),
                  SizedBox(height: 7 * screenHeight),
                  SizedBox(
                    width: 207 * screenWidth,
                    child: Text(
                      'Put an end to all your plumberig Issues',
                      style: TextStyle(
                        height: 1.3,
                        color: Color(0xffd2d2d2),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 8 * screenHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$' + '45' + '/hr',
                        style: TextStyle(
                          color: Color(0xff0c46b6),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text('Read More!',
                            style: TextStyle(
                              color: Color(0xff0c46b6),
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    ));
  }
}
