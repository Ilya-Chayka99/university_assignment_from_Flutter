import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final Widget? child;
  const Box({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 42, 41, 33),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(136, 0, 0, 0),
            blurRadius: 15,
            offset: Offset(4, 4),
          )
        ]
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}