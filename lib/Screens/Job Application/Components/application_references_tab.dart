// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Components/profile_item.dart';

import '../../../Components/appointment_tab_row.dart';
import '../../../constants.dart';

class ApplicationReferencesTab extends StatefulWidget {
  const ApplicationReferencesTab({
    super.key,
  });

  @override
  State<ApplicationReferencesTab> createState() =>
      _ApplicationReferencesTabState();
}

class _ApplicationReferencesTabState extends State<ApplicationReferencesTab> {
  final linkController = TextEditingController();
  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  void showReferenceDialog() async {
    referenceLinkError = false;
    final updatedLinks = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          title: Center(
            child: Text(
              'Add References',
              style: TextStyle(
                  color: black, fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 260 * screenWidth,
                        child: TextField(
                          autofocus: true,
                          controller: linkController,
                          keyboardType: TextInputType.url,
                          cursorHeight: 18 * screenHeight,
                          enableSuggestions: true,
                          autocorrect: true,
                          cursorColor: black,
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: 'Enter in-app link',
                            focusedBorder: referenceLinkError
                                ? OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(color: red))
                                : OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(color: primary),
                                  ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide:
                                  BorderSide(color: appointmentTimeColor),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w200,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15 * screenWidth,
                                vertical: 15 * screenHeight),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: black,
                            fontSize: 16,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!jobApplicationLinks
                                    .contains(linkController.text.trim()) &&
                                jobApplicationLinks.length != 5 &&
                                linkController.text.trim() != '') {
                              jobApplicationLinks
                                  .add(linkController.text.trim());
                              linkController.clear();
                            } else {
                              setState(() {
                                referenceLinkError = true;
                              });
                            }
                          });
                        },
                        child: Container(
                          height: 49 * screenHeight,
                          width: 40 * screenWidth,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: Icon(Icons.check, color: white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  referenceLinkError
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10 * screenHeight),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  if (linkController.text.trim() == '')
                                    Text(
                                      'Text field cannot be empty.',
                                      style: TextStyle(
                                          color: red,
                                          height: 1.3,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  if (jobApplicationLinks.length == 5)
                                    Text(
                                      'Maximum number of links reached.',
                                      style: TextStyle(
                                          height: 1.3,
                                          color: red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  if (jobApplicationLinks
                                      .contains(linkController.text.trim()))
                                    Text(
                                      '${linkController.text.trim()} already added.',
                                      style: TextStyle(
                                          height: 1.3,
                                          color: red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  jobApplicationLinks.isEmpty
                      ? SizedBox()
                      : SizedBox(height: 18 * screenHeight),
                  jobApplicationLinks.isEmpty
                      ? SizedBox()
                      : SizedBox(
                          width: 310 * screenWidth,
                          height: 180 * screenHeight,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 49 * screenHeight,
                                width: 310 * screenWidth,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: appointmentTimeColor, width: 1),
                                ),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10 * screenWidth),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 265 * screenWidth,
                                      child: Text(
                                        jobApplicationLinks[index],
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          jobApplicationLinks.removeAt(index);
                                        });
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: primary,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 12 * screenHeight);
                            },
                            itemCount: jobApplicationLinks.length,
                          ),
                        ),
                  SizedBox(height: 30 * screenHeight),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, jobApplicationLinks);
                    },
                    child: Container(
                      height: 49 * screenHeight,
                      width: 312 * screenWidth,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: sectionColor, width: 3)),
                      child: Center(
                        child: Text(
                          'Save',
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
          ),
        );
      },
    );

    if (updatedLinks != null) {
      setState(() {
        jobApplicationLinks = updatedLinks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * screenWidth,
          vertical: 19 * screenHeight,
        ),
        constraints: BoxConstraints(minHeight: 135 * screenHeight),
        width: 383 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppointmentTabRow(tabTitle: 'References', isCustomVisible: false),
            SizedBox(height: 22 * screenHeight),
            GestureDetector(
              onTap: showReferenceDialog,
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
                        'Link:',
                        style: TextStyle(
                          color: chatTimeColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 42),
                      Text(
                        'Add references here...',
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
            Padding(
              padding: EdgeInsets.only(left: screenHeight * 11.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  jobApplicationLinks.isEmpty
                      ? SizedBox()
                      : SizedBox(height: 20 * screenHeight),
                  jobApplicationLinks.isEmpty
                      ? SizedBox()
                      : SizedBox(
                          width: 323 * screenWidth,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 49 * screenHeight,
                                width: 290 * screenWidth,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: appointmentTimeColor, width: 1),
                                ),
                                // alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10 * screenWidth),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 200 * screenWidth,
                                      child: Text(
                                        jobApplicationLinks[index],
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          jobApplicationLinks.removeAt(index);
                                        });
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: primary,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 12 * screenHeight);
                            },
                            itemCount: jobApplicationLinks.length,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
