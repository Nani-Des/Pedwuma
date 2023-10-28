import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Services/read_data.dart';
import '../../../constants.dart';
import '../../../Components/appointment_tab_row.dart';

class ApplicationChargeDetails extends StatefulWidget {
  final TextEditingController chargeController;
  const ApplicationChargeDetails({
    super.key,
    required this.chargeController,
  });

  @override
  State<ApplicationChargeDetails> createState() =>
      _ApplicationChargeDetailsState();
}

String jobApplicationChargeRate = 'N/A';

class _ApplicationChargeDetailsState extends State<ApplicationChargeDetails> {
  @override
  void initState() {
    widget.chargeController.text = allJobItemList[0].charge.toString();
    if (allJobItemList[0].chargeRate == 'Hr') {
      jobApplicationChargeRate = 'Hour';
    } else if (allJobItemList[0].chargeRate == '6 Hrs') {
      jobApplicationChargeRate = '6 Hours';
    } else {
      jobApplicationChargeRate = '12 Hours';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * screenWidth,
          vertical: 19 * screenHeight,
        ),
        height: 155 * screenHeight,
        width: 383 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppointmentTabRow(
                tabTitle: 'Charge Details', isCustomVisible: false),
            SizedBox(height: 22 * screenHeight),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Charge',
                        style: TextStyle(
                          color: textGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 11 * screenHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            width: 143 * screenWidth,
                            height: 34 * screenHeight,
                            child: Center(
                              child: TextField(
                                autofocus: false,
                                controller: widget.chargeController,
                                keyboardType: TextInputType.number,
                                cursorHeight: 16 * screenHeight,
                                enableSuggestions: true,
                                autocorrect: false,
                                inputFormatters: [
                                  FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                      allow: true),
                                  LengthLimitingTextInputFormatter(3)
                                ],
                                cursorColor: black,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: white,
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: 'Enter charge here...',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                    BorderSide(color: appointmentTimeColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                    BorderSide(color: appointmentTimeColor),
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: textGreyColor,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  // contentPadding: EdgeInsets.symmetric(
                                  //     horizontal: 15 * screenWidth,
                                  //     vertical: 15 * screenHeight),
                                ),
                                textCapitalization:
                                TextCapitalization.sentences,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: black,
                                  fontSize: 16,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8 * screenWidth),
                          Container(
                            height: 34 * screenHeight,
                            width: 36 * screenWidth,
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(9),
                                border:
                                Border.all(color: appointmentTimeColor)),
                            alignment: Alignment.center,
                            child: Text(
                              '\$',
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Charge Rate',
                        style: TextStyle(
                          color: textGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 11 * screenHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownButton2(
                            buttonStyleData: ButtonStyleData(
                              elevation: 0,
                              height: 34 * screenHeight,
                              width: 100 * screenWidth,
                              padding: EdgeInsets.only(
                                  left: 8 * screenWidth,
                                  right: 4 * screenWidth),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: appointmentTimeColor, width: 1)),
                            ),
                            underline: Text(''),
                            dropdownStyleData: DropdownStyleData(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3 * screenWidth,
                                  vertical: 10 * screenHeight),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            iconStyleData: IconStyleData(
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: black),
                            ),
                            isExpanded: true,
                            hint: Center(
                              child: Text(
                                'Choose one',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: black,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            items:
                            chargePerList.map((String serviceCategoryList) {
                              return DropdownMenuItem(
                                value: serviceCategoryList,
                                child: Text(
                                  serviceCategoryList,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                jobApplicationChargeRate = newValue!;
                              });
                            },
                            value: jobApplicationChargeRate.toString(),
                          ),
                        ],
                      )
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
