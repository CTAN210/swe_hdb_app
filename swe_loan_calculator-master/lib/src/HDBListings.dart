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

  /// Each HDB Listing will have their own attributes as declared below.

    /// town: The location of the listing, i.e. Ang Mo Kio, Bishan, Toa Payoh, etc.
   String town;
   /// storey_range: The range of the floor of the listing. No exact storey is given.
   String storey_range;
   /// floor_area_sqm: The floor area of the listing given in sqm.
   double floor_area_sqm;
   /// flat_model: The flat model of the listing, i.e. New Generation, Improved, etc.
   String flat_model;
   /// flat_type: The flat type of the listing, i.e. 1 Room, 2 Room, etc.
   String flat_type;
   /// lease_commence_date: The date that the listing obtained its lease. Each lease expires after 99 years.
   double lease_commence_date;
   /// remaining_lease: The time remaining on the lease of the listing, measured in Years and Months.
   String remaining_lease;
   /// resale_price: The price at which the listing is being sold at.
   double resale_price;
   /// longitude: The longitude value of the listing's location
   double longitude;
   /// latitude: The latitude value of the listing's location
   double latitude;
   /// address: The address of the listing, given by it's street name and block number.
   String address;
   /// ID: The unique identifier number of each listing.
   double ID;

  HDBListing({
    this.town,
    this.storey_range,
    this.floor_area_sqm,
    this.flat_model,
    this.flat_type,
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