import 'package:flutter/material.dart';
import 'package:src/utils/constants.dart';

class EDButton extends StatelessWidget {
  final VoidCallback pressHandle;
  final String text;

  const EDButton({
    super.key,
    required this.pressHandle,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      width: double.infinity,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: pressHandle,
            style: TextButton.styleFrom(
                backgroundColor: ELDORADO_YELLOW,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                )),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
