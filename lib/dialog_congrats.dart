import 'package:defector/menu_screen.dart';
import 'package:flutter/material.dart';

class DialogCongrats extends StatelessWidget {
  const DialogCongrats({Key? key}) : super(key: key);

  static show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const DialogCongrats(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Congratulations!!!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                'Thank you so much!\nYou have eliminated the great evil from our world!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DefectorButton(
                text: 'you are welcome',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
