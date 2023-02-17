import 'package:flutter/material.dart';

class StepDP extends StatelessWidget {
  final String text;

  const StepDP({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: Colors.purple.shade700,
        ),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
