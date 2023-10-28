import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';
import 'default_back_button.dart';

class DrawerHeaderCreated extends StatelessWidget {
  const DrawerHeaderCreated({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        DefaultBackButton(),
        SizedBox(width: 15 * screenWidth),
        Container(
          height: 50 * screenHeight,
          width: 50 * screenWidth,
          decoration: BoxDecoration(
            color: white,
            shape: BoxShape.circle,
            border: imageUrl == ''
                ? Border.all(color: sectionColor, width: 1)
                : null,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
          child: imageUrl == ''
              ? Center(child: Icon(Icons.person, color: grey))
              : null,
        ),
        SizedBox(width: 15 * screenWidth),
        Text(
          '0 ${AppLocalizations.of(context)!.ep}',
          style: TextStyle(
            color: black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
