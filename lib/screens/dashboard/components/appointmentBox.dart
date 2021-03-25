import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/models/appointment.dart';
import 'package:thcMobile/components/skillsBox.dart';
import 'package:thcMobile/services/base.dart';
import '../appointments/appointmentDetails.dart';

class AppointmentBox extends StatefulWidget {
  final Appointment appointment;
  final GestureTapCallback onPressed;
  final bool isPrevious;
  AppointmentBox(
      {Key key,
      @required this.onPressed,
      @required this.appointment,
      @required this.isPrevious})
      : super(key: key);
  @override
  _AppointmentBoxState createState() => _AppointmentBoxState();
}

class _AppointmentBoxState extends State<AppointmentBox> {
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
    String day = widget.appointment.date.split('-')[2];
    String month = months[int.parse(widget.appointment.date.split('-')[1])];
    String year = widget.appointment.date.split('-')[0];
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Material(
            color: Color(0xffF9FBFD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => AppointmentDetails(
                          appointment: widget.appointment,
                          isPrevious: widget.isPrevious)),
                );
              },
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: sizer(false, 20, context),
                      horizontal: sizer(true, 20, context)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xffF9FBFD),
                      border: Border.all(color: Color(0xffDFE8FC), width: 1.0)),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            widget.appointment.doctor != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(22.5),
                                    child: Image.network(
                                        widget.appointment.doctor.photo,
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50))
                                : Container(),
                            SizedBox(width: sizer(true, 10, context)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                widget.appointment.doctor != null
                                    ? Text(
                                        "Dr " +
                                            widget.appointment.doctor.user.name,
                                        style: TextStyle(
                                          color: Color(0xff071232),
                                          fontWeight: FontWeight.w500,
                                          fontSize: sizer(true, 16.0, context),
                                        ),
                                      )
                                    : Text(''),
                                SizedBox(height: 2),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    height: 20,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.appointment.doctor != null
                                              ? widget.appointment.doctor
                                                  .areaOfSpecialization.length
                                              : 0,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              SkillsBox(
                                        title: widget.appointment.doctor != null
                                            ? widget
                                                .appointment
                                                .doctor
                                                .areaOfSpecialization[index]
                                                .name
                                            : '',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                widget.appointment.doctor != null
                                    ? Text(
                                        widget.appointment.doctor.hospital.bio,
                                        style: TextStyle(
                                          color: Color(0xff8E919C),
                                          fontSize: sizer(true, 14, context),
                                        ),
                                      )
                                    : Text(''),
                              ],
                            ),
                            Spacer(),
                            Material(
                              color: Color(0xffF3F4F8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF3F4F8),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                      child: Icon(Icons.arrow_forward,
                                          size: 20, color: Color(0xff091118))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(
                          thickness: 1.0,
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Container(
                                width: 190,
                                child: Row(children: [
                                  widget.appointment.callRecording
                                      ? videoBox()
                                      : SizedBox(),
                                  SizedBox(width: 15),
                                  // widget.appointment.severity != null &&
                                  //         widget.appointment.severity == 'high'
                                  //     ?
                                  Row(
                                    children: [
                                      urgentBox(),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  // : Container(),
                                ])),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(day + ' ' + month + ', ' + year,
                                    style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(height: 0.0),
                                Text(
                                    widget.appointment.preferredTime
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Color(0xff071232),
                                      fontSize: sizer(true, 16.0, context),
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                      ])),
            )));
  }

  Widget divider() {
    return Container(
      height: 0.7,
      color: Color(0xffDFE8FC),
    );
  }

  Widget urgentBox() {
    return Container(
      height: 45,
      width: 110,
      alignment: Alignment.center,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 111, 79, 0.2),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Row(children: <Widget>[
        Icon(Icons.error, size: 22, color: Color(0xffFF6F4F)),
        SizedBox(width: sizer(true, 7, context)),
        Text('Urgent',
            style: TextStyle(
                color: Color(0xffFF6F4F),
                fontSize: 15,
                fontWeight: FontWeight.w500))
      ]),
    );
  }

  Widget videoBox() {
    return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(135, 79, 255, 0.21),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Icon(Icons.videocam, size: 30, color: Color(0xff874FFF))));
  }
}
