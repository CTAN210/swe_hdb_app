// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppingmalls.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Mall _$MallFromJson(Map<String, dynamic> json) {
  return Mall(
    name: json['name'] as String,
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MallToJson(Mall instance) => <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
    };

ShoppingMalls _$ShoppingMallsFromJson(Map<String, dynamic> json) {
  return ShoppingMalls(
    malls: (json['malls'] as List)
        ?.map(
            (e) => e == null ? null : Mall.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ShoppingMallsToJson(ShoppingMalls instance) =>
    <String, dynamic>{
      'malls': instance.malls,
    };
