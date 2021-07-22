import 'package:flutter/material.dart';
import 'package:gp_version_01/models/item.dart';

class MyOfferItems extends StatelessWidget {
  final Item offer;
  MyOfferItems({this.offer});

  @override
  Widget build(BuildContext context) {
    final sizee = MediaQuery.of(context).size.height -
        MediaQuery.of(context).size.height * 0.24;
    return SizedBox(
      height: sizee * 0.6,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      offer.images[0],
                      fit: BoxFit.cover,
                      height: (sizee * 0.6) * 0.6,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
              Container(
                height: ((sizee * 0.6) * 0.35),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text(
                      offer.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: (((sizee * 0.6) * 0.35) * 0.11),
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      offer.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: (((sizee * 0.6) * 0.35) * 0.1),
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        Text(
                          offer.location[0] + " - " + offer.location[1],
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: (((sizee * 0.6) * 0.35) * 0.1),
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
