import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/details_screen.dart';

class ProductItem extends StatelessWidget {
  final int index;
  final listOfUrl;
  ProductItem({this.index, this.listOfUrl});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),*/
      child: Container(
        /*decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),*/
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                 /* borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),*/
                  child: Image.network(
                    listOfUrl[index],
                    fit: BoxFit.cover,
                    height: 225,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.star_border, color: Colors.white),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    "سماعه بلوتوث شقيه جدا",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "يمكن للطاقة أن تأخذ أشكالًا متنوعة منها طاقة حرارية، كيميائية، كهربائية، إشعاعية، نووية، طاقة كهرومغناطيسية، وطاقة حركية. هذه الأنواع من الطاقة يمكن تصنيفها بكونها طاقة حركية أو طاقة كامنة، في حين أن بعضها يمكن أن يكون مزيجًا من الطاقتين الكامنة والحركية معًا، وهذا يدرس في الديناميكا الحرارية.",
                    style: TextStyle(fontWeight: FontWeight.w300),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Text(
                        "زهراء المعادي",
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
