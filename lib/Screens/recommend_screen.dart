import 'package:flutter/material.dart';
import 'package:gp_version_01/widgets/Grid.dart';

class Recommend extends StatelessWidget {
  static const String route = "Recommend";

  final List urls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsw1cmBNAvLSVIG9WgLtoqnMJypzgJdigLCqrHWYZw3MpD43Yz3UYUdV4zbX-sYg0Pyp735SA&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXOot-fOsgB1F-SbN9cmo6FycyyMBaGU2EDpo9adXChrysAroKiAizrNgxb2H-glY08Td0OBR_&usqp=CAc',
    'https://www.thebalancesmb.com/thmb/0NefRBrg_lU-vxqzclEne4RU3R8=/640x360/smart/filters:no_upscale()/dressshoes1-f5db6a43f1714b609c772f6c0c1814df.jpg',
    'https://cdn.pixabay.com/photo/2020/01/16/20/48/renault-4771773__340.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuK2hFNkWSyawRdEVauV8fUccTeFOvgCAvsA&usqp=CAU',
    'https://cdn11.bigcommerce.com/s-vwd6a/images/stencil/2048x2048/products/604/3563/parrotlet_blue__41318.1571248358.jpg?c=2',
    'https://img1.ouedkniss.com/photos_annonces/25706131/Photo1.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2T7JSYjV9a6M61g2aI0Bqr0aN5Tm-Q51UcbryfilNFAIcpHnYSyVhZQamDBg&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXBQHXqPjdssAJ_xwurZN3WhJNa18FQq8Q9g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQebbQSHmkjeAZi6TfnG5FCjaaaXE-dmzyoA&usqp=CAU',
    'https://www.inverness-courier.co.uk/_media/img/750x0/HQU1244SU1XHLL8RMMEB.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "مقترح لك",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
        ),
        body: Grid(urls: urls));
  }
}
