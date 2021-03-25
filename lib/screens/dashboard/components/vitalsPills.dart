import 'package:flutter/material.dart';

class VitalsPills extends StatefulWidget {
  VitalsPills({
    @required this.bp,
    @required this.pulse,
    @required this.index,
    @required this.spo2,
    @required this.date,
    @required this.time,
  });
  final String bp, pulse, spo2;
  final int index;
  final String date, time;
  @override
  _VitalsPillsState createState() => _VitalsPillsState();
}

class _VitalsPillsState extends State<VitalsPills> {
  String _suffix = "";

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.index % 2 == 0 ? Colors.white : Color(0xffF3F4F8),
      ),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.37,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.blue[900],
                  size: 14,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${widget.date} \t\t${widget.time}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.bp,
            style: TextStyle(
              color: Color(0xff22D389),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          Text(
            widget.pulse,
            style: TextStyle(
              color: Color(0xff22D389),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          Text(
            widget.spo2 + "%",
            style: TextStyle(
              color: Color(0xff22D389),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
