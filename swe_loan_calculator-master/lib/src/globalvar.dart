/*
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart';
import 'HDBListings.dart' as locations;




class HDBLists {

  Future<locations.HDBListingModel> rootHDBData() async {
    final HDBData = await locations.getHDBListing();
    // final List <locations.HDBListing> finalList = [];
    return HDBData;
  }

  Future<locations.HDBListingModel> hdb = rootHDBData();
}


class FilterConditions {
  final int upperPV;
  final int lowerPV;
  final int upperFlArea;
  final int lowerFlArea;
  final int value1;
  final int value2;
  final int remainLease;

  FilterConditions({
    this.upperPV,
    this.lowerPV,
    this.upperFlArea,
    this.lowerFlArea,
    this.value1,
    this.value2,
    this.remainLease,
  })
}

class filteredHDBList{
  List<locations.HDBListing> filteredListing;

  filteredHDBList({
    this.filteredListing,
});

  final String abc=  locations.HDBListing.town;

}


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

}*/
