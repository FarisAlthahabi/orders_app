import 'package:json_annotation/json_annotation.dart';

class DoubleConverter implements JsonConverter<double, String> {
  const DoubleConverter();

  @override
  double fromJson(String json) => double.parse(json);

  @override
  String toJson(double object) => object.toString();
}
