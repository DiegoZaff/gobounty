import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bounty {
  String title;
  String description;
  double reward;
  LatLng location;
  int points;
  int nPeople;

  Bounty(
      {required this.title,
      required this.description,
      required this.reward,
      required this.location,
      required this.points,
      this.nPeople = 1});
}

List<Bounty> bounties = [
  Bounty(
      title: "Find my cat",
      description: "My cat is missing, please help me find it",
      reward: 100,
      location: const LatLng(45.467384, 9.182410),
      points: 100),
  Bounty(
      title: "Find my dog",
      description: "My dog is missing, please help me find it",
      reward: 200,
      location: const LatLng(45.466384, 9.136410),
      points: 200),
  Bounty(
      title: "Find my bird",
      description: "My bird is missing, please help me find it",
      reward: 300,
      location: const LatLng(45.666384, 9.786410),
      points: 300),
];
