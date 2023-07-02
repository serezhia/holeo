import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holeo/src/core/utils/extensions/context_extension.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.stringOf().appTitle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.stringOf().helloName('serezhia'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/camera');
                },
                child: const Text('Go to camera'),
              )
            ],
          ),
        ),
      );
}
