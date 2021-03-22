import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart';

part 'HDBListings.g.dart';


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
class HDBListing{

   String town;
   String storey_range;
   double floor_area_sqm;
   String flat_model;
   double lease_commence_date;
   String remaining_lease;
   double resale_price;
   double longitude;
   double latitude;
   String address;
   double ID;

  HDBListing({
    this.town,
    this.storey_range,
    this.floor_area_sqm,
    this.flat_model,
    this.lease_commence_date,
    this.remaining_lease,
    this.resale_price,
    this.longitude,
    this.latitude,
    this.address,
    this.ID
  });

  factory HDBListing.fromJson(Map<String, dynamic> json) => _$HDBListingFromJson(json);
  Map<String, dynamic> toJson() => _$HDBListingToJson(this);

  // HDBListing.fromJson(Map<String, dynamic> json) {
  //   town = json['town'];
  //    storey_range = json['storey_range'];
  //    floor_area_sqm = json['floor_area_sqm'];
  //    flat_model = json['flat_model'];
  //    lease_commence_date = json['lease_commence_date'];
  //    remaining_lease = json['remaining_lease'];
  //    resale_price = json['resale_price'];
  //    longitude = json['longitude'];
  //    latitude = json['latitude'];
  //    address = json['address'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //  return {
  //    'town': town,
  //    'storey_range': storey_range,
  //    'floor_area_sqm': floor_area_sqm,
  //    'flat_model': flat_model,
  //    'lease_commence_date': lease_commence_date,
  //    'remaining_lease': remaining_lease,
  //    'resale_price': resale_price,
  //    'longitude': longitude,
  //    'latitude': latitude,
  //    'address': address
  //  };
  // }

}

@JsonSerializable()
class HDBListingModel {
  HDBListingModel({
    this.items
  });

  factory HDBListingModel.fromJson(Map<String, dynamic> json) =>
      _$HDBListingModelFromJson(json);
  Map<String, dynamic> toJson() => _$HDBListingModelToJson(this);

  final List<HDBListing> items;
}


Future<HDBListingModel> getHDBListing() async {
  final response = await rootBundle.loadString('assets/HDBListings.json');
  return HDBListingModel.fromJson(json.decode(response));
}



// do this at the parent widget -- pass data into variables and can pass data around