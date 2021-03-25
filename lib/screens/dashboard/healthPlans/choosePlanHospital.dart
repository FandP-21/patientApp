import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/choosePlanType.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/components/optionItem.dart';
import 'choosePlanHospital.dart';

class ChoosePlanHospital extends StatefulWidget {
  ChoosePlanHospital({Key key, @required this.title, @required this.id})
      : super(key: key);
  final String title;
  final int id;

  @override
  _ChoosePlanHospitalState createState() => _ChoosePlanHospitalState();
}

class _ChoosePlanHospitalState extends State<ChoosePlanHospital> {
  List<dynamic> _labHmoPlans = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    fetchPlans();
  }

  void fetchPlans() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    Response response;
    Dio dio = Dio();

    response = await dio.get(url + "hospital-billing-r/${widget.id}/",
        options: Options(headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        }));
    List<dynamic> store = response.data;
    for (int i = 0; i < store.length; i++) {
      if (store[i]['category']['name'] == 'Registration Pricing') {
        _labHmoPlans.add(store[i]);
      }
    }
    setState(() => loading = false);
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
          child: Padding(
            padding: EdgeInsets.only(
                top: sizer(false, 50, context),
                left: sizer(true, 20, context),
                right: sizer(true, 20, context)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BackButtonWhite(
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: sizer(false, 15, context)),
                HeaderText(title: widget.title),
                SizedBox(
                  height: 8,
                ),
                SubText(isCenter: false, title: 'Choose a health plan'),
                SizedBox(
                    height: sizer(false,
                        MediaQuery.of(context).size.height * 0.1, context)),
                loading ? CenterLoader() : SizedBox(),
                _labHmoPlans.length > 0
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: _labHmoPlans.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                OptionItem(
                                    hasPadding: true,
                                    title: _labHmoPlans[index]['name'] ?? 'N/A',
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChoosePlanType(
                                                  hmoId: widget.id,
                                                  hmoPlanId: _labHmoPlans[index]
                                                      ['id'],
                                                  title: _labHmoPlans[index]
                                                      ['name'],
                                                  monthly: _labHmoPlans[index]
                                                      ['six_months_price'],
                                                  yearly: _labHmoPlans[index]
                                                      ['one_year_price'],
                                                  description:
                                                      _labHmoPlans[index]
                                                          ['notes'],
                                                  identifier: 'hospital',
                                                ))))))
                    : loading
                        ? SizedBox()
                        : EmptyData(
                            title: "No Plans available",
                            isButton: false,
                          ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
