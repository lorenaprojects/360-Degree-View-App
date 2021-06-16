// Copyright 2021 Lorena Munoz. //
// All rights reserved. Lorena Projects. //

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  double longitude = 0;
  double speed = 0.001;
  int counter = 100;

  Timer _timer;

  Widget iconWidget = Container(
    height: 1,
    width: 1,
    color: Colors.transparent,
  );

  void _updateTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          _timer.cancel();
          speed = 0.001;
        }
      });
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Colors.white,
                width: 2,
              )),
          title: Text(
            'Triceratops',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          content: Text(
            'Triceratops is a genus of herbivorous ceratopsid dinosaur that first appeared during the late Maastrichtian stage of the late Cretaceous period, about 68 million years ago (mya) in what is now North America.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                _updateTimer();
                speed = 1.5;
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildIcon() {
    if (counter >= 95 && counter <= 100) {
      iconWidget = Positioned(
        top: MediaQuery.of(context).size.height / 2,
        left: MediaQuery.of(context).size.width / 2,
        child: GestureDetector(
          onTap: () {
            _showDialog();
            speed = 0.001;
            _timer.cancel();
          },
          child: Container(
            child: Icon(
              Icons.search,
              size: 55,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else if (counter <= 15) {
      iconWidget = Positioned(
        top: MediaQuery.of(context).size.height / 2,
        left: MediaQuery.of(context).size.width / 2,
        child: GestureDetector(
          onTap: () {
            _showDialog();
            speed = 0.001;
            _timer.cancel();
          },
          child: Container(
            child: Icon(
              Icons.search,
              size: 55,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return iconWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            children: <Widget>[
              Panorama(
                interactive: true,
                animSpeed: speed,
                longitude: longitude,
                latitude: 0,
                child: Image.asset(
                  'images/Pacific.jpg',
                ),
              ),
              buildIcon(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            speed = 1.5;
            _updateTimer();
          });
        },
        child: Text(
          counter.toString(),
        ),
      ),
    );
  }
}
