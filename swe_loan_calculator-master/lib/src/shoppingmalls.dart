import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart';

part 'shoppingmalls.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    this.lat,
    this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Mall{
  Mall({
    this.name,
    this.lat,
    this.lng,
  });

  factory Mall.fromJson(Map<String, dynamic> json) => _$MallFromJson(json);
  Map<String, dynamic> toJson() => _$MallToJson(this);

  final String name;
  final double lat;
  final double lng;
}

@JsonSerializable()
class ShoppingMalls {
  ShoppingMalls({
    this.malls
  });

  factory ShoppingMalls.fromJson(Map<String, dynamic> json) =>
      _$ShoppingMallsFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingMallsToJson(this);

  final List<Mall> malls;
}

Future<ShoppingMalls> getShoppingMalls() async {

  final response = await rootBundle.loadString('assets/MallCoordinates.json');
  return ShoppingMalls.fromJson(json.decode(response));
}