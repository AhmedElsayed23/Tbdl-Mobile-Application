import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/widgets/my_offer.dart';


class MakeOffer extends StatelessWidget {
  static const String route = "MakeOffer";

  final List urls = [
      'https://content.avito.ma/images/10/10018192643.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPaf6EZvTG7jJ4BamjuO7di8sHCdLz2WEBMviDFlUigovetZ8iAjTnmPUDVA&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMY7yXRnDhd153tj6lRBv6YXDb91cKeKdqWA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6Ryf82Cb2kg8Li_ZkH0gfC5HkmFdNkL-cqlSu6efXcNiFZmRSHNI-0jo60S_iwx3MwY8BFpc&usqp=CAc',
    'https://cdn.pixabay.com/photo/2017/09/03/16/58/car-2711177__340.jpg',
    'https://1.bp.blogspot.com/-VuLYkiFm41o/XTlggPkNqXI/AAAAAAAAABI/1Uu1RopU2sglPQiZ33_KCj40xIVEtCJNQCLcBGAs/s1600/3beeae1c-5811-425f-89c0-1821ef9ecf61.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO8Xhjc8urY1Zo7zv6QoDIDQ6lMGiPv9bYwg&usqp=CAU',
    'https://p0.pikist.com/photos/814/525/footwear-men-s-shoes-black-shoes.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkPhmAtW9kftRP3GBxB0EwoPXBPZLBxamFHw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKF92O1GQNO2DR_t-fxFr5hOmQzRCveBPIxQ&usqp=CAU',
    'https://cdn.pixabay.com/photo/2016/04/17/21/43/jeep-1335619__340.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcfFO6vElcocqEW4GgdL8_rmDF8q8YGjItX6Z0j2NjSE-39f-LfdjXKqjzTt8Mei1brkgL-cN5&usqp=CAc',
    'https://i.pinimg.com/originals/ed/51/a2/ed51a299eba6ec3a295cb63799a0417e.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("منتجاتى", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: urls.length,

        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: (){},
          child: MyOffers(
            index: index,
            listOfUrl: urls,
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
