part of 'camera_bloc.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState.initial() = _InitialState;
  const factory CameraState.cameraReady({
    required CameraController cameraController,
  }) = _CameraReadyState;
  const factory CameraState.cameraFailure({
    required int code,
  }) = _CameraFailureState;
  const factory CameraState.cameraCaptureInProgress() =
      _CameraCaptureInProgressState;
  const factory CameraState.cameraCaptureSuccess() = _CameraCaptureSuccessState;
  const factory CameraState.cameraCaptureFailure() = _CameraCaptureFailureState;
}
