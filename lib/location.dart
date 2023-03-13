import 'dummyLabs.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key key}) : super(key: key);

  @override
  _LocationServiceState createState() => _LocationServiceState();
}

class _LocationServiceState extends State<LocationService> {
  Position _currentUserPosition;
  double distanceImMeter = 0.0;
  Data data = Data();

  Future _getTheDistance() async {
    _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(_currentUserPosition);

    int smallestRoute = 99999999;
    for (int i = 0; i < data.allLabs.length; i++) {
      double Lablat = data.allLabs[i]['lat'];
      double Lablng = data.allLabs[i]['lng'];

      double distanceImMeter = await Geolocator.distanceBetween(
        _currentUserPosition.latitude,
        _currentUserPosition.longitude,
        Lablat,
        Lablng,
      );
      var distance = distanceImMeter.round().toInt();

      data.allLabs[i]['distance'] = (distance / 100);
      if ((distance / 100).round() < smallestRoute) {
        smallestRoute = (distance / 100).round();
      }
      print(smallestRoute);
      setState(() {});
    }
  }

  @override
  void initState() {
    _getTheDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        title: Text("Labs for taking the exams!"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: GridView.builder(
            itemCount: data.allLabs.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.purpleAccent,
                height: height * 0.9,
                width: width * 0.3,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.12,
                      width: width,
                      child: Image.network(
                        data.allLabs[index]['image'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      data.allLabs[index]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text(
                          "${data.allLabs[index]['distance'].round()} KM Away",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
