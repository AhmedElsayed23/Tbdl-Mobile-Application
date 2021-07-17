import 'package:flutter/material.dart';
import 'package:gp_version_01/models/item.dart';

class DescriptionItemOther extends StatelessWidget {
  final Item item;
  DescriptionItemOther(this.item);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                      child: Text(
                        (item.condition) ? 'جديد' : 'مستعمل',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                Spacer(),
                Container(
                    child: Text(
                  'النوع',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                      child: Text(
                        (item.isFree) ? 'بدون مقابل' : 'بمقابل',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                Spacer(),
                Container(
                    child: Text(
                  'بمقابل مادي ام لا',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
