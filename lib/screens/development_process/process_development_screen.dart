import 'package:flutter/material.dart';
import 'package:digiscan/screens/development_process/components/body_development_process.dart';

class DevelopmentProcessScreen extends StatelessWidget {
  const DevelopmentProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyDevelopmentProcess(),
    );
  }
}
