import 'package:flutter/material.dart';

import '../constants.dart';

class SavedAddresses extends StatefulWidget {
  final VoidCallback screen;
  final int index;

  const SavedAddresses({Key? key, required this.index, required this.screen})
      : super(key: key);

  @override
  State<SavedAddresses> createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 50 * screenHeight),
      width: 310 * screenWidth,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: appointmentTimeColor, width: 1),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 15 * screenWidth, vertical: 12 * screenHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Address ' + (widget.index + 1).toString(),
                style: TextStyle(
                  color: primary,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: widget.screen,
                child: Container(
                  height: 20 * screenHeight,
                  width: 20 * screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: white,
                      border: Border.all(
                        color: appointmentTimeColor,
                        width: 1,
                      )),
                  alignment: Alignment.center,
                  child: Icon(Icons.add, color: primary),
                ),
              ),
            ],
          ),
          Text(
            addressHouseNum[widget.index] +
                ',\n' +
                addressStreetName[widget.index] +
                ', ' +
                addressTownName[widget.index] +
                ',\n' +
                addressRegionName[widget.index] +
                ', Ghana',
            style: TextStyle(color: black, fontSize: 16, height: 1.3),
          ),
          SizedBox(height: 10 * screenHeight),
        ],
      ),
    );
  }
}
