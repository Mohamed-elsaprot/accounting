import 'package:flutter/material.dart';
import '../views/home.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key, this.function}) : super(key: key);
  final Function? function;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
                (route) => false);
          function;
        },
        icon: const Icon(Icons.home,size: 30,));
  }
}


