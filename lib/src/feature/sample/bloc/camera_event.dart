part of 'camera_bloc.dart';

@freezed
class CameraEvent with _$CameraEvent {
  const factory CameraEvent.cameraInitialized() = _CameraInitialized;
  const factory CameraEvent.cameraChangeLense() = _CameraChangeLense;
  const factory CameraEvent.cameraStopped() = _CameraStopped;
  const factory CameraEvent.cameraCaptured() = _CameraCaptured;
}
