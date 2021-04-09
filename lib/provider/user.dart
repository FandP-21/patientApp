import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  String _id = '';
  String _mainId = '';
  String _token = '';
  String _baseUrl = "https://thc2020.herokuapp.com/";
  String _name = '';
  String _lname = '';
  String _deviceToken = '';
  String _mobileNumber = '';
  String _patient = '';

  UserModel() {
    getData();
  }

  get id => _id;

  get mainId => _mainId;

  get token => _token;

  get baseUrl => _baseUrl;

  get name => _name;

  get lname => _lname;

  get deviceToken => _deviceToken;

  get mobileNumber => _mobileNumber;

  get patient => _patient;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('id') ?? '');
    String mainId = (prefs.getString('main_id') ?? '');
    String token = (prefs.getString('token') ?? '');
    String name = (prefs.getString('name') ?? '');
    String deviceToken = (prefs.getString('deviceToken') ?? '');
    String mobileNumber = (prefs.getString('mobileNumber') ?? '');
    String lname = (prefs.getString('Lname') ?? "");
    String patient = prefs.getString('patient') ?? '';

    _id = id;
    _mainId = mainId;
    _token = token;
    _name = name;
    _deviceToken = deviceToken;
    _mobileNumber = mobileNumber;
    _lname = lname;
    _patient = patient;
    notifyListeners();
  }

  Future<bool> setDeviceToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _deviceToken = value;
    notifyListeners();
    return prefs.setString('deviceToken', value);
  }

  Future<bool> setId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = value;
    notifyListeners();
    return prefs.setString('id', value);
  }

  Future<bool> setMobileNumber(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _mobileNumber = value;
    notifyListeners();
    return prefs.setString('moibileNumber', value);
  }

  Future<bool> setMainId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _mainId = value;
    notifyListeners();
    return prefs.setString('main_id', value);
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = value;
    notifyListeners();
    return prefs.setString('token', value);
  }

  Future<bool> setName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = value;
    notifyListeners();
    return prefs.setString('name', value);
  }

  Future<bool> setLName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _lname = value;
    notifyListeners();
    return prefs.setString('Lname', value);
  }

  Future<bool> setPatient(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _patient = value;
    notifyListeners();
    return prefs.setString('patient', value);
  }
}
