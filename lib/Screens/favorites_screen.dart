import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Screens/details_screen.dart';
import 'package:gp_version_01/widgets/product_Item.dart';

class Favorites extends StatelessWidget {
  static const String route = "Favorites";

  List urls = [
   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7-IV3YpRnewzrc0TcCZkbkMkihZP6DjPXKA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR3Gn2tIlpRL7hrO2shrO34YKERjiShiRJ7w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6LzgrlxDmE4G24tJjkiL2vgDQuwqezpN_QA&usqp=CAU',
    'https://www.motortrend.com/uploads/sites/5/2014/10/2012-Honda-Accord-SE-sedan-front-three-quarter.jpg',
    'https://i.pinimg.com/originals/78/81/bf/7881bf62ac85a752263143028f1124b5.jpg',
    'https://super1number.com/wp-content/uploads/2020/08/%D8%A7%D9%81%D8%B6%D9%84-%D9%86%D8%AC%D8%A7%D8%B1-%D8%A7%D8%A8%D9%88%D8%B8%D8%A8%D9%8A.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpv_ZEIiEzM_mk3jv0QnW_AsjicMxubtQBUw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHT__g2qt75-avu-97gLQ02CQ0MTJVrGnZKA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaACpI7bWPgsPp3LkEyWOegUtrS1MVX7toF20jtMafMv7od0P3i1QZQmlePdqMZNX-dbpFNBR1&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRahYRsn_70I15f9tWEEOT8V8w9subSUeiyQ4Hqc1k8FcH5Tbsu_61CFNxoIlUDYmC7n1ht749s&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl3mE_RMsOu0ueZ1NmIa0hsdbNTE8Z6NJan8mCJ6x_CiohUL36DfcTjp-I-hg&usqp=CAc',
    'https://argaamplus.s3.amazonaws.com/aacce10a-735e-473f-97ca-90445ddc9903.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المفضلة", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: urls.length,

        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () => Navigator.pushNamed(context, Details.route,
              arguments: urls[index]),
          child: ProductItem(
            index: index,
            listOfUrl: urls,
            isFavorite: true,
          ),
        ),

        staggeredTileBuilder: (int index) => StaggeredTile.count(
            2, MediaQuery.of(context).size.aspectRatio * 7.5),
        //mainAxisSpacing: 5,
        //crossAxisSpacing: 5,
      ),
    );
  }
}
