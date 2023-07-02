import 'package:camera/camera.dart';
// import 'package:holeo/src/feature/sample/widget/camera_screen.dart';
import 'package:l/l.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraRepository {
  CameraRepository();

  late CameraController _cameraController;

  bool _isInit = false;

  bool get _isNotInit => !_isInit;

  late List<CameraDescription> _cameras;

  CameraController get cameraController => _cameraController;

  Future<void> init(CameraLensDirection lensDirection) async {
    try {
      l.d('Проверка статуса разрешения камеры');
      final status = await Permission.camera.status;
      l.d('Статус: $status');
      if (!status.isGranted) {
        l.d('Запрос на получение разрешения использовать камеру');
        final requset = await Permission.camera.request();

        if (!requset.isGranted) {
          l.d('Запрос отклонен');
          throw HoleoCameraExeption(
            id: 1,
            error: 'Camera permission status is denied',
          );
        }
      }
      // Получаем доступные камеры
      l.d('Запрашиваем разрешение на камеру и получаем доступные');
      _cameras = await availableCameras();
      if (_cameras.isEmpty || _cameras.length < 2) {
        throw Exception('Not доступна камера');
      }
      l.d('Берем камеру с нужной линзой и создаем контроллер');
      // Берем камеру с нужной линзой и создаем контроллер
      _cameraController = CameraController(
        _cameras
            .firstWhere((element) => element.lensDirection == lensDirection),
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.bgra8888,
      );
      l.d('_isInit = true');

      // Запускаем камеру

      if (_isNotInit) {
        await _cameraController.initialize();
      }
      l.d('CameraId: ${_cameraController.cameraId}');
      _isInit = true;
      l.d('Инициализируем камеру');
    } on HoleoCameraExeption catch (_) {
      rethrow;
    } on Object catch (e) {
      l.e('Failed init: $e');
    }
  }

  Future<void> dispose() async {
    if (_isNotInit) return;
    l.d('Диспоуз камеры:');
    // Завершаем прцоесс камеры
    await _cameraController.dispose();
    l.d('_isInit = false:');
    _isInit = false;
  }

  Future<XFile> takePicture() async {
    if (_isInit) {
      return _cameraController.takePicture();
    } else {
      throw Exception('Camera not init');
    }
  }

  /// Из-за косяка setDescription создаем инстантс  _cameraController каждый раз
  /// https://github.com/flutter/flutter/issues/126823
  /// Репозиторий управления камерой
  Future<void> changeCamera() async {
    l.d('Сработал метод смены линзы');
    if (_isNotInit) {
      l.d('Смена не удалась потому что камера не инициализирована');
      return;
    }

    final currentLense = _cameraController.value.description.lensDirection;
    late final CameraLensDirection nextLense;
    l.d('Текущая линза $currentLense');
    switch (currentLense) {
      case CameraLensDirection.front:
        nextLense = CameraLensDirection.back;
        break;
      case CameraLensDirection.back:
        nextLense = CameraLensDirection.front;
        break;
      default:
        nextLense = CameraLensDirection.front;
        break;
    }
    l.d('Ставим линзу $nextLense');
    await dispose();
    await init(nextLense);
  }
}

class HoleoCameraExeption implements Exception {
  HoleoCameraExeption({
    required this.id,
    required this.error,
    this.description,
  });

  final int id;

  ///
  final String error;
  final String? description;
}
