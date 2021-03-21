import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/widgets/my_offer.dart';


class MakeOffer extends StatelessWidget {
  static const String route = "MakeOffer";

  List urls = [
    'https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg?fbclid=IwAR2QDnBRbxwB02FnZi8KkwbrEluyuUxhhRSslqBvCcqEbaG60sfFK08jHSQ',
    'https://images.unsplash.com/photo-1543783207-ec64e4d95325?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80&fbclid=IwAR3PDJqyLYiy0TFN2a-fuu0Q7Qqp2DTU9M5lyaXx4n0aVufjUnaA-zGzWDc',
    'https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&w=1000&q=80&fbclid=IwAR3VTlMP89trSaXlkUt_Yu7VNQi4QrnjpUaAsbIEf7ypZLijJJZmRH_BOk8',
    'https://creativepro.com/wp-content/uploads/2019/05/imagetext01.jpg?fbclid=IwAR2qxe1wN3zDmStGv0GJdQZ6y0cda7R0DRjjXM-rMDvfgp5jMIJXE5_lKJA',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg?fbclid=IwAR3gUBIwQLcxRUdR94YSUOKft-Ms4BKfulq2BrtbmvjxvRcFf1Zx9jIbfwo',
    'https://i.pinimg.com/originals/82/c2/8a/82c28a10da93fae1360986a3823fdf11.jpg?fbclid=IwAR0YL6lWpuhxl8u5hxhL-Alz52dpAH7eCoAs8VPv78VD_OnWnkgnEKAU5kk',
    'https://cdn.pocket-lint.com/r/s/1200x/assets/images/151442-cameras-feature-stunning-photos-from-the-national-sony-world-photography-awards-2020-image1-evuxphd3mr.jpg',
    'https://images.unsplash.com/photo-1535463731090-e34f4b5098c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80&fbclid=IwAR0d_7wLBsYR1ADCQKvhthAQBYwhXn8GM2Akl9b4wpa3bOX94TMQN3z-igs',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("عروضى"),
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
