import 'package:flutter/material.dart';

class SuggestionWidget extends StatelessWidget {
  String icon;
  String text;
  SuggestionWidget({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Center(
        child: Container(
          height: 32.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0x27FFFFFF),
            ),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            color: Colors.black,
          ),
          child: (icon == "")
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Color(0xFFF9F9F9),
                      fontSize: 14.0,
                    ),
                  ),
                )
              : Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 12.0,
                        right: 6.0,
                      ),
                      child: Image.asset(
                        icon,
                        width: 13.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 13.0, top: 8.0, bottom: 8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Color(0xFFF9F9F9),
                          fontSize: 14.0,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
