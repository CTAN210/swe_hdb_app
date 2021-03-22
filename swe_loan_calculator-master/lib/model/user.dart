import 'package:meta/meta.dart';

class User {
  final String street;
  final String block;
  final String town;
  final String storey_range;
  final String floor_area_sqm;
  final String flat_model;
  final String lease_commence_date;
  final String remaining_lease;
  final String resale_price;
  final String longitude;
  final String latitude;

  const User({
    @required this.street,
    @required this.block,
    @required this.town,
    @required this.storey_range,
    @required this.floor_area_sqm,
    @required this.flat_model,
    @required this.lease_commence_date,
    @required this.remaining_lease,
    @required this.resale_price,
    @required this.longitude,
    @required this.latitude,
  });

  static User fromJson(json) => User(
    street: json['street'],
    block: json['block'],
    town: json['town'],
    storey_range: json['storey_range'],
    floor_area_sqm: json['floor_area_sqm'],
    flat_model: json['flat_model'],
    lease_commence_date: json['lease_commence_date'],
    remaining_lease: json['remaining_lease'],
    resale_price: json['resale_price'],
    longitude: json['longitude'],
    latitude: json['latitude'],
  );

}