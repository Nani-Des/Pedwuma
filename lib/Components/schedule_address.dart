import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_item.dart';
import 'package:handyman_app/Components/profile_item_dropdown.dart';

import '../constants.dart';
import 'address_bars.dart';
import 'appointment_tab_row.dart';

class ScheduleAddress extends StatefulWidget {
  const ScheduleAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleAddress> createState() => _ScheduleAddressState();
}

class _ScheduleAddressState extends State<ScheduleAddress> {
  final townController = TextEditingController();
  final houseNumController = TextEditingController();
  final streetController = TextEditingController();

  void _AddressDialogBox() {
    setState(() {});
    showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AlertDialog(
              insetPadding: EdgeInsets.all(10),
              backgroundColor: Colors.transparent,
              content: Container(
                height: 390 * screenHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(24)),
                padding: EdgeInsets.symmetric(
                  vertical: 22 * screenWidth,
                  horizontal: 20.5 * screenWidth,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text('Address Information',
                          style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    SizedBox(height: 10 * screenHeight),
                    ProfileAddressItem(
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(
                              "[a-zA-Z0-9\\s]")), // Only allow letters and spaces
                          LengthLimitingTextInputFormatter(18),
                        ],
                        textEditingController: streetController,
                        title: 'Street name',
                        hintText: 'Enter street name...',
                        keyboardType: TextInputType.streetAddress),
                    SizedBox(height: 10 * screenHeight),
                    ProfileAddressItem(
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(
                              "[a-zA-Z\\s]")), // Only allow letters and spaces
                          LengthLimitingTextInputFormatter(18),
                        ],
                        textEditingController: townController,
                        title: 'Town',
                        hintText: 'Enter town name...',
                        keyboardType: TextInputType.name),
                    SizedBox(height: 20 * screenHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RegionSelect(dropdownList: regionsList),
                        Spacer(),
                        ProfileAddressItem(
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  "[a-zA-Z0-9\\s]")), // Only allow letters and spaces
                              LengthLimitingTextInputFormatter(10),
                            ],
                            textEditingController: houseNumController,
                            isWidthMax: false,
                            width: 118,
                            title: 'House No',
                            hintText: 'House No.',
                            keyboardType: TextInputType.name),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  apppointmentTown = townController.text.trim();
                  apppointmentStreet = streetController.text.trim();
                  apppointmentHouseNum = houseNumController.text.trim();
                });
                Navigator.pop(context);
                streetController.clear();
                townController.clear();
                houseNumController.clear();
              },
              child: Container(
                height: 49 * screenHeight,
                width: 310 * screenWidth,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: sectionColor, width: 3)),
                child: Center(
                  child: Text(
                    'Save Address',
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * screenWidth,
          vertical: 19 * screenHeight,
        ),
        // height: 183 * screenHeight,
        width: 383 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppointmentTabRow(
              tabTitle: 'Address',
              isCustomVisible: false,
              isRecallAddressVisisble: true,
            ),
            SizedBox(height: 16 * screenHeight),
            Center(
              child: DropdownButton2(
                items: addressOptions.map((String addressOptionsList) {
                  return DropdownMenuItem(
                    value: addressOptionsList,
                    child: Text(
                      addressOptionsList,
                      style: TextStyle(
                        color: black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
                buttonStyleData: ButtonStyleData(
                  height: 34 * screenHeight,
                  width: 322 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(width: 1, color: appointmentTimeColor),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 15 * screenWidth),
                ),
                iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: EdgeInsets.only(right: screenWidth * 8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 17,
                      color: black,
                    ),
                  ),
                ),
                isExpanded: true,
                style: TextStyle(
                  color: black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20 * screenWidth,
                        vertical: 10 * screenHeight)),
                autofocus: false,
                underline: Text(''),
                onChanged: (String? newValue) {
                  setState(() {
                    addressValue = newValue!;
                  });
                },
                value: addressValue,
                selectedItemBuilder: (BuildContext context) {
                  return addressOptions
                      .map<Widget>((String addressOptionsList) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Type:',
                          style: TextStyle(
                            color: chatTimeColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 90 * screenWidth,
                        ),
                        Text(
                          addressOptionsList,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),
            ),
            SizedBox(height: 10 * screenHeight),
            GestureDetector(
              onTap: () {
                _AddressDialogBox();
              },
              child: Center(
                child: Container(
                  height: 34 * screenHeight,
                  width: 322 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(width: 1, color: appointmentTimeColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15 * screenWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Full Address:',
                        style: TextStyle(
                          color: chatTimeColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Add here...',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 14 * screenHeight),
            apppointmentTown == ''
                ? SizedBox()
                : Center(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 50 * screenHeight),
                      width: 322 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: appointmentTimeColor, width: 1),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15 * screenWidth,
                          vertical: 12 * screenHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Builder(builder: (context) {
                                return Text(
                                  '$addressValue Address',
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 16,
                                  ),
                                );
                              }),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    apppointmentTown = '';
                                    apppointmentStreet = '';
                                    apppointmentHouseNum = '';
                                    apppointmentRegion = '';
                                  });
                                },
                                child: Container(
                                    height: 25 * screenHeight,
                                    width: 25 * screenWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: white,
                                        border: Border.all(
                                          color: appointmentTimeColor,
                                          width: 1,
                                        )),
                                    child: Icon(
                                      Icons.remove,
                                      color: primary,
                                    )),
                              ),
                            ],
                          ),
                          Text(
                            '$apppointmentHouseNum,\n$apppointmentStreet, $apppointmentTown,\n$apppointmentRegion, Ghana',
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 10 * screenHeight),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
