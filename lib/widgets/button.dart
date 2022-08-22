import 'package:flutter/material.dart';

class DefectorButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const DefectorButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black;
          }
          return Colors.white;
        }),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 20,
            fontFamily: 'Minecraft',
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.white;
          }
          return Colors.black;
        }),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
        ),
      ),
    );
  }
}
