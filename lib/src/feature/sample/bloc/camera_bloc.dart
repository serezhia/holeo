import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:holeo/src/feature/sample/repositoris/camera_repository.dart';

part 'camera_event.dart';
part 'camera_state.dart';
part 'camera_bloc.freezed.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc({required this.cameraRepository})
      : super(const CameraState.initial()) {
    on<CameraEvent>((event, emit) async {
      await event.map(
        cameraInitialized: (event) async {
          try {
            emit(const CameraState.initial());
            await cameraRepository.init(CameraLensDirection.front);
            emit(
              CameraState.cameraReady(
                cameraController: cameraRepository.cameraController,
              ),
            );
          } on HoleoCameraExeption catch (e) {
            emit(CameraState.cameraFailure(code: e.id));
          } on Object catch (_) {
            emit(const CameraState.cameraFailure(code: 666));
          }
        },
        cameraStopped: (event) async {
          try {
            await cameraRepository.dispose();
          } on Object catch (_) {
            emit(const CameraState.cameraFailure(code: 666));
          }
        },
        cameraCaptured: (event) async {
          try {
            emit(const CameraState.cameraCaptureInProgress());
            await cameraRepository.takePicture();
            emit(const CameraState.cameraCaptureSuccess());
          } on Object catch (_) {
            emit(const CameraState.cameraFailure(code: 666));
          }
        },
        cameraChangeLense: (event) async {
          try {
            emit(const CameraState.initial());
            await cameraRepository.changeCamera();
            emit(
              CameraState.cameraReady(
                cameraController: cameraRepository.cameraController,
              ),
            );
          } on Object catch (_) {
            emit(const CameraState.cameraFailure(code: 666));
          }
        },
      );
    });
  }

  final CameraRepository cameraRepository;
}
