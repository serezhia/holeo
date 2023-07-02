// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:app_settings/app_settings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holeo/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:holeo/src/feature/sample/bloc/camera_bloc.dart';

class CameraScreenBuilder extends StatelessWidget {
  const CameraScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CameraBloc(
          cameraRepository: context.dependencies.cameraRepository,
        ),
        child: const CameraScreen(),
      );
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late final CameraBloc cameraBloc;
  @override
  void initState() {
    cameraBloc = context.read<CameraBloc>()
      ..add(const CameraEvent.cameraInitialized());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Camera'),
        ),
        body: BlocBuilder<CameraBloc, CameraState>(
          builder: (context, state) => state.map(
            initial: (state) => const Center(
              child: CircularProgressIndicator(),
            ),
            cameraReady: (state) => Stack(
              children: [
                CameraPreview(state.cameraController),
              ],
            ),
            cameraFailure: (state) => Center(
              child: Column(
                children: [
                  Text('Error: ${state.code}'),
                  ElevatedButton(
                    onPressed: () {
                      cameraBloc.add(const CameraEvent.cameraInitialized());
                    },
                    child: const Text('Retry'),
                  ),
                  if (state.code == 1)
                    ElevatedButton(
                      onPressed: () async {
                        await AppSettings.openAppSettings(
                          callback: () {
                            cameraBloc
                                .add(const CameraEvent.cameraInitialized());
                          },
                        );
                      },
                      child: const Text('Open settings'),
                    ),
                ],
              ),
            ),
            cameraCaptureInProgress: (state) => const Center(
              child: CircularProgressIndicator(),
            ),
            cameraCaptureSuccess: (state) => const Center(
              child: CircularProgressIndicator(),
            ),
            cameraCaptureFailure: (state) => const Center(
              child: Text('Error'),
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<CameraBloc, CameraState>(
          builder: (context, state) => state.maybeMap(
            cameraReady: (state) => FloatingActionButton(
              onPressed: () {
                cameraBloc.add(const CameraEvent.cameraChangeLense());
              },
            ),
            orElse: SizedBox.new,
          ),
        ),
      );
  @override
  void dispose() {
    cameraBloc.add(const CameraEvent.cameraStopped());
    super.dispose();
  }
  // if (!controller.value.isInitialized) {
  //   return Container();
  // }
  // return Scaffold(
  //   appBar: AppBar(
  //     title: const Text('Camera'),
  //   ),
  //   body:
  //   floatingActionButton: FloatingActionButton(
  //     onPressed: () async {
  //       final picture = await controller.takePicture();
  //       // ignore: use_build_context_synchronously
  //       final router = GoRouter.of(context);
  //       await router.push('/camera/result', extra: picture);
  //     },
  //     child: const Icon(Icons.camera),
  //   ),
  // );
}
