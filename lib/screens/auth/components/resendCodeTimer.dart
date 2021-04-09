import 'package:flutter/material.dart';
import 'dart:async';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class ResendCodeTimer extends StatefulWidget {
  ResendCodeTimer(
      {Key key,
      @required this.start,
      @required this.loading,
      @required this.resendToken})
      : super(key: key);
  final bool loading;
  final Function resendToken;
  final int start;

  @override
  _ResendCodeTimerState createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends State<ResendCodeTimer> {
  Timer _timer;
  var oneSecond = const Duration(seconds: 1);
  String _suffix = '00';
  int count = 1;
// int widget.start = 60;
  @override
  void initState() {
    super.initState();
    // startTimer();
    count = widget.start;
    pad(widget.start);
  }

  pad(int n) {
    _timer = new Timer.periodic(
        oneSecond,
        (Timer t) => setState(() {
              if (n == 0)
                _timer.cancel();
              else if (n < 10)
                setState(() {
                  _suffix = ("0" + n.toString());
                });
              else
                setState(() {
                  _suffix = n.toString();
                });
              n -= 1;
              count = n;
            }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loading) {
      //    startTimer();
    }
    return Material(
        color: Color(0xffE7EEFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          // side: BorderSide(color: Colors.red)
        ),
        child: GestureDetector(
            onTap: count < 1
                ? () {
                    widget.resendToken();
                  }
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: count > 1 ? Color(0xffE7EEFF) : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    count > 1 ? 'RESEND CODE IN ' : 'RESEND CODE',
                    style: TextStyle(
                        color: Color(0xff245DE8),
                        fontSize: sizer(true, 14, context),
                        fontWeight: FontWeight.w700),
                  ),
                  count > 1
                      ? Text('00:$_suffix',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: sizer(true, 14, context),
                              fontWeight: FontWeight.w700))
                      : Container(),
                  SizedBox(width: 10),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Color(0xff245DE8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 10.0,
                      color: Colors.white,
                    )),
                  )
                ],
              ),
            )));
  }
}
