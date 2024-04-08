import 'package:flutter/material.dart';
import 'package:gobounty/classes/Bounty.dart';
import 'package:gobounty/utils/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Bounty? selectedBounty;

  void setSelectedBounty(Bounty bounty) {
    setState(() {
      selectedBounty = bounty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.logo_dev),
          onPressed: () {
            // Add your onPressed logic here
          },
        ),
        title: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: purple),
            onPressed: () {
              // Add your onPressed logic here
            },
            child: const Text('My Bounties',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMapWidget(
              setSelectedBounty:
                  setSelectedBounty), // Display Google Maps widget
         selectedBounty != null ? DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.5,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          const Text(
                            "Bounty",
                            style: TextStyle(
                                color: purple,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${selectedBounty?.points}",
                                style: const TextStyle(
                                    color: purple, fontSize: 20),
                              ),
                              const Icon(
                                Icons.star,
                                color: purple,
                                size: 30,
                              )
                            ],
                          )
                        ],
                      ),
                      Text(
                        selectedBounty?.title ?? "",
                        style: const TextStyle(
                            color: greyText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        selectedBounty?.description ?? "",
                        style: const TextStyle(
                          color: greyText,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.people, color: purple, size: 30),
                          const SizedBox(width: 10),
                          Text(
                            "x${selectedBounty?.nPeople} ${selectedBounty?.nPeople == 1 ? "person" : "people"}",
                            style: const TextStyle(
                              color: greyText,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.euro,
                              color: purple, size: 30),
                          const SizedBox(width: 10),
                          Text(
                            "Ricompensa €${selectedBounty?.reward.toInt()} a persona",
                            style: const TextStyle(
                              color: greyText,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
            },
          ) : Container(),
        ],
      ),
    );
  }
}

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key, required this.setSelectedBounty});

  final Function setSelectedBounty;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  // ignore: unused_field
  late GoogleMapController _controller;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    for (var bounty in bounties) {
      markers.add(Marker(
        //custom image
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        onTap: () => widget.setSelectedBounty(bounty),
        markerId: MarkerId(bounty.title),
        position: bounty.location,
        infoWindow:
            InfoWindow(title: bounty.title, snippet: bounty.description),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        setState(() {
          _controller = controller;
        });
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(45.466384, 9.186410), // Milan, IT
        zoom: 12,
      ),
      markers: markers,
    );
  }
}
