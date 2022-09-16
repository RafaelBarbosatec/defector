import 'package:defector/widgets/button.dart';
import 'package:flutter/material.dart';

class DialogGameOver extends StatelessWidget {
  static show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const DialogGameOver(),
    );
  }

  const DialogGameOver({Key? key}) : super(key: key);

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
                'Game Over',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                child: DefectorButton(
                  text: 'Try Again',
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/game',
                      (route) => false,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: DefectorButton(
                  text: 'Exit',
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
