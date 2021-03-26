// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HDBListings.dart';

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

HDBListing _$HDBListingFromJson(Map<String, dynamic> json) {
  return HDBListing(
    town: json['town'] as String,
    storey_range: json['storey_range'] as String,
    floor_area_sqm: (json['floor_area_sqm'] as num)?.toDouble(),
    flat_model: json['flat_model'] as String,
    flat_type: json['flat_type'] as String,
    lease_commence_date: (json['lease_commence_date'] as num)?.toDouble(),
    remaining_lease: json['remaining_lease'] as String,
    resale_price: (json['resale_price'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    latitude: (json['latitude'] as num)?.toDouble(),
    address: json['address'] as String,
    ID: (json['ID'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$HDBListingToJson(HDBListing instance) =>
    <String, dynamic>{
      'town': instance.town,
      'storey_range': instance.storey_range,
      'floor_area_sqm': instance.floor_area_sqm,
      'flat_model': instance.flat_model,
      'flat_type': instance.flat_type,
      'lease_commence_date': instance.lease_commence_date,
      'remaining_lease': instance.remaining_lease,
      'resale_price': instance.resale_price,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'address': instance.address,
      'ID': instance.ID,
    };

HDBListingModel _$HDBListingModelFromJson(Map<String, dynamic> json) {
  return HDBListingModel(
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : HDBListing.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HDBListingModelToJson(HDBListingModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
