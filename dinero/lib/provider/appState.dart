import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _email = '';
  String _name = '';
  String _username = '';
  String _phoneNumber = '';
  bool _customer;
  bool _vendor;
  String _accessToken;
  int _id;

  AppState() {
    getData();
  }

  Future<Null> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email") ?? '';
    String name = prefs.getString("name") ?? '';
    String username = prefs.getString("username") ?? '';
    String phoneNumber = prefs.getString("phoneNumber") ?? '';
    String accessToken = prefs.getString("key") ?? '';
    bool customer = prefs.getBool("cuatomer") ?? false;
    bool vendor = prefs.getBool("vendor") ?? false;
    int id = prefs.getInt("id") ?? 0;

    _email = email;
    _name = name;
    _username = username;
    _phoneNumber = phoneNumber;
    _customer = customer;
    _vendor = vendor;
    _accessToken = accessToken;
    _id = id;

    notifyListeners();
  }

  get email => _email;
  get name => _name;
  get username => _username;
  get phoneNumber => _phoneNumber;
  get customer => _customer;
  get vendor => _vendor;
  get token => _accessToken;
  get id => _id;

  Future setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = value;
    notifyListeners();
    prefs.setString("email", value);
  }

  Future setName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = value;
    notifyListeners();
    prefs.setString("name", value);
  }

  Future setUsername(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = value;
    notifyListeners();
    prefs.setString("username", value);
  }

  Future setPhoneNumber(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _phoneNumber = value;
    notifyListeners();
    prefs.setString("phoneNumber", value);
  }

  Future setCustomer(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _customer = value;
    notifyListeners();
    prefs.setBool("customer", value);
  }

  Future setVendor(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _vendor = value;
    notifyListeners();
    prefs.setBool("vendor", value);
  }

  Future setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = value;
    notifyListeners();
    prefs.setString("key", value);
  }

  Future setId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = value;
    notifyListeners();
    prefs.setInt("id", value);
  }
}
