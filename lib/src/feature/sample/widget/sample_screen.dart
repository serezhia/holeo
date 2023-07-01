import 'package:flutter/material.dart';
import 'package:holeo/src/core/utils/extensions/context_extension.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.stringOf().appTitle),
        ),
        body: Column(
          children: [
            Text(
              context.stringOf().helloName('serezhia'),
            ),
          ],
        ),
      );
}
