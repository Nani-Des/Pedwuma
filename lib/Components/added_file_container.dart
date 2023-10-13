import 'package:flutter/material.dart';

import '../constants.dart';

class AddedFileContainer extends StatefulWidget {
  bool isMomoOptions;
  final int index;
  final Widget child;
  final String fileName;
  AddedFileContainer(
      {Key? key,
      required this.index,
      required this.child,
      required this.fileName,
      this.isMomoOptions = false})
      : super(key: key);

  @override
  State<AddedFileContainer> createState() => _AddedFileContainerState();
}

class _AddedFileContainerState extends State<AddedFileContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49 * screenHeight,
      width: 310 * screenWidth,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(7),
      ),
      padding: EdgeInsets.only(
        top: 14 * screenHeight,
        bottom: 14 * screenHeight,
        left: 15 * screenWidth,
        right: 13 * screenWidth,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.isMomoOptions
              ? SizedBox(height: 0, width: 0)
              : Image.asset('assets/icons/pdf.png'),
          widget.isMomoOptions &&
                  selectedMomoOptions[widget.index] == momoListOptions[0]
              ? Image.asset(selectedMomoOptionsIcons[0])
              : SizedBox(height: 0, width: 0),
          widget.isMomoOptions &&
                  selectedMomoOptions[widget.index] == momoListOptions[1]
              ? Image.asset(selectedMomoOptionsIcons[1])
              : SizedBox(height: 0, width: 0),
          widget.isMomoOptions &&
                  selectedMomoOptions[widget.index] == momoListOptions[2]
              ? Image.asset(selectedMomoOptionsIcons[2])
              : SizedBox(height: 0, width: 0),
          widget.isMomoOptions
              ? SizedBox(height: 0, width: 0)
              : Padding(
                  padding: EdgeInsets.only(left: screenWidth * 10.0),
                  child: SizedBox(
                    width: 192 * screenWidth,
                    child: Text(
                      widget.fileName,
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ),
          widget.isMomoOptions ? SizedBox(width: 15 * screenWidth) : SizedBox(),
          widget.isMomoOptions
              ? Text(
                  selectedMomoOptions[widget.index],
                  style: TextStyle(
                    color: black,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                )
              : SizedBox(height: 0, width: 0),
          Spacer(),
          widget.child,
          SizedBox(width: 3.31 * screenWidth),
        ],
      ),
    );
  }
}
