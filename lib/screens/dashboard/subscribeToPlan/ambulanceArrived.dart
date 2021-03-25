import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonWhite.dart';
import 'package:thcMobile/components/buttonBlack.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/dashboard/index.dart';

class AmbulanceArrived extends StatefulWidget {
  AmbulanceArrived({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AmbulanceArrivedState createState() => _AmbulanceArrivedState();
}

class _AmbulanceArrivedState extends State<AmbulanceArrived> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new Stack(
            children: <Widget>[
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: height(5, true, context)),
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                    height: 50,
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
                      Container(
                          height: 50,
                          width: width(70, true, context),
                          decoration: BoxDecoration(
                              color: Color(0xffFF6F4F),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            'assets/images/ambulanceRed.png',
                            fit: BoxFit.fill,
                          )),
                      Container(
                          height: 50,
                          width: width(70, true, context),
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/charge.png',
                                    width: 30, height: 30, fit: BoxFit.contain),
                                SizedBox(width: 5),
                                Text('You ambulance will arrive in 3mins',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: sizer(true, 14, context),
                                        fontWeight: FontWeight.w500))
                              ])),
                    ])),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: sizer(true, 20, context),
                    vertical: sizer(false, 30, context),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff071232),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '02:59 min',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: sizer(true, 32, context),
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: sizer(false, 5, context),
                              ),
                              Text(
                                'Arrival time',
                                style: TextStyle(
                                    color: Color(0xffBFBCC3),
                                    fontSize: sizer(true, 16.0, context),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset('assets/images/patient.png',
                                fit: BoxFit.cover, width: 50, height: 50),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizer(false, 17, context),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sizer(true, 13, context),
                          vertical: sizer(false, 30, context),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff121e3c),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: sizer(true, 8, context),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Your location',
                                  style: TextStyle(
                                      color: Color(0xffBFBCC3),
                                      fontSize: sizer(true, 14, context),
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '51, Iwaya Road, Onike, Yaba',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: sizer(true, 16.0, context),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizer(false, 45, context),
                      ),
                      ButtonWhite(onPressed: () {}, title: 'CALL AMBULANCE'),
                      SizedBox(
                        height: sizer(false, 13, context),
                      ),
                      ButtonBlack(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Dashboard(loading: null))),
                          title: 'CANCEL REQUEST')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
