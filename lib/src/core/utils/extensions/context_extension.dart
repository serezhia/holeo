import 'package:flutter/widgets.dart';
import 'package:holeo/src/core/localization/app_localization.dart';

extension LocalizationX on BuildContext {
  GeneratedLocalization stringOf() =>
      AppLocalization.stringOf<GeneratedLocalization>(this);
}
