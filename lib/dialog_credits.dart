import 'package:defector/menu_screen.dart';
import 'package:defector/widgets/button.dart';
import 'package:flutter/material.dart';

class DialogCredits extends StatelessWidget {
  static show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const DialogCredits(),
    );
  }

  const DialogCredits({Key? key}) : super(key: key);

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
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Credits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Dev:',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Rafael Almeida Barbosa',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const Text(
                'https://github.com/RafaelBarbosatec',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'PixelArte:',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'LazyFox',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const Text(
                'https://lazy-fox.itch.io/',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Package gamedev:',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Bonfire',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'https://bonfire-engine.github.io',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                child: DefectorButton(
                  text: 'Fechar',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
