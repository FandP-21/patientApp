import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/components/skillsBox.dart';

class GoToDoctorBox extends StatefulWidget {
  final Doctor doctor;
  final GestureTapCallback onPressed;
  GoToDoctorBox({Key key, @required this.onPressed, @required this.doctor})
      : super(key: key);
  @override
  _GoToDoctorBoxState createState() => _GoToDoctorBoxState();
}

class _GoToDoctorBoxState extends State<GoToDoctorBox> {
  @override
  void initState() {
    super.initState();
    print(widget.doctor.isIndependent);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            margin: EdgeInsets.only(bottom: sizer(false, 20, context)),
            padding: EdgeInsets.only(bottom: sizer(false, 20, context)),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffF3F4F8), width: 1.0))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget.doctor.photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(22.5),
                        child: Image.network(widget.doctor.photo,
                            fit: BoxFit.cover, width: 50, height: 50))
                    : Container(),
                SizedBox(width: sizer(true, 15, context)),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Dr " + widget.doctor.user.name,
                        style: TextStyle(
                            color: Color(0xff071232),
                            fontWeight: FontWeight.w500,
                            fontSize: sizer(true, 16.0, context))),
                    SizedBox(height: 3),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 20,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.doctor.areaOfSpecialization.length,
                          itemBuilder: (BuildContext context, int index) =>
                              SkillsBox(
                            title:
                                widget.doctor.areaOfSpecialization[index].name,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    widget.doctor.isIndependent == true ||
                            widget.doctor.isIndependent.toString() == 'true'
                        ? Text("Independent consultant")
                        : Text(widget.doctor.hospital.bio,
                            style: TextStyle(
                                color: Color(0xff8E919C),
                                fontSize: sizer(true, 14, context)))
                  ],
                )),
                SizedBox(width: sizer(true, 15, context)),
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
          ),
        ),
      ),
    );
  }
}
