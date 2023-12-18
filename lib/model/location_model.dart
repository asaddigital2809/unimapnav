import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel{
  final String? name;
  final String? ground;
  final bool? forDisabled;
  final GeoPoint? points;

  LocationModel({
    this.name,
    this.points,
    this.ground,
    this.forDisabled
  });

  factory LocationModel.fromJson(Map<String, dynamic> json){
    return LocationModel(
      name: json['name'],
      ground: json['floor'],
      forDisabled: json['forDisabled'],
      points: json['points']
    );
  }
}