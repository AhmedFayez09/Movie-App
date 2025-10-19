import 'package:qeema_task/src/core/utils/constant.dart';

extension StrNullableExtension on String? {
  bool get  nullOrEmpty => this == null || this == "";
  String get fullLink =>  "${Constant.imagesBase}$this";
}
