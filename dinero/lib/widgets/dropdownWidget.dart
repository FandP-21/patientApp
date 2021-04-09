import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  DropdownWidget({@required this.store, @required this.title, this.onChanged});
  final List store;
  final String title;
  final ValueChanged onChanged;

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _title;

  @override
  void initState() {
    super.initState();
    setState(() {
      _title = widget.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20, top: 7, right: 20),
        height: 60,
        decoration: BoxDecoration(
          color: defaultBlack,
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton<String>(
          hint: Text(
            _title,
            style: TextStyle(
                color: defaultGreen,
                fontWeight: FontWeight.w300,
                fontSize: bodyText),
          ),
          items: widget.store.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
              onTap: () {
                setState(() {
                  _title = value;
                });
              },
            );
          }).toList(),
          onChanged: widget.onChanged,
          isExpanded: true,
          style: TextStyle(
              color: defaultGreen,
              fontWeight: FontWeight.w300,
              fontSize: bodyText),
          underline: SizedBox(),
          dropdownColor: defaultBlack,
          iconDisabledColor: deepGreen,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: defaultGreen,
          ),
        ),
      ),
    );
  }
}
