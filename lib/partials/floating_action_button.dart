<<<<<<< HEAD
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
=======
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
<<<<<<< HEAD
=======
>>>>>>> 21e5289 (initial commit)
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
