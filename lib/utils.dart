import 'dart:math' show sin, cos, tan, atan;
import 'package:flutter/cupertino.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:vector_math/vector_math.dart' show radians, degrees;
import 'qiblah_compass.dart';

class Utils {
  static var _deLa = 0.0;
  static var _deLo = 0.0;

  void btnText(String btnText) {
    if (btnText == "Qibla") {
      _deLa = radians(21.4225);
      _deLo = radians(39.8262);
    } else {
      _deLa = radians(36.2880);
      _deLo = radians(59.6158);
    }
  }

  static double getOffsetFromNorth(
      double currentLatitude, double currentLongitude) {
    var laRad = radians(currentLatitude);
    var loRad = radians(currentLongitude);

    var toDegrees = degrees(atan(sin(_deLo - loRad) /
        ((cos(laRad) * tan(_deLa)) - (sin(laRad) * cos(_deLo - loRad)))));
    if (laRad > _deLa) {
      if ((loRad > _deLo || loRad < radians(-180.0) + _deLo) &&
          toDegrees > 0.0 &&
          toDegrees <= 90.0) {
        toDegrees += 180.0;
      } else if (loRad <= _deLo &&
          loRad >= radians(-180.0) + _deLo &&
          toDegrees > -90.0 &&
          toDegrees < 0.0) {
        toDegrees += 180.0;
      }
    }
    if (laRad < _deLa) {
      if ((loRad > _deLo || loRad < radians(-180.0) + _deLo) &&
          toDegrees > 0.0 &&
          toDegrees < 90.0) {
        toDegrees += 180.0;
      }
      if (loRad <= _deLo &&
          loRad >= radians(-180.0) + _deLo &&
          toDegrees > -90.0 &&
          toDegrees <= 0.0) {
        toDegrees += 180.0;
      }
    }
    return toDegrees;
  }
}
