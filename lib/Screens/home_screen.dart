import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gp_version_01/Screens/details_screen.dart';
import 'package:gp_version_01/Screens/favorites_screen.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/Screens/recommend_screen.dart';
import 'package:gp_version_01/widgets/product_Item.dart';
import '../widgets/drawer.dart';
import 'chooseCategory_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "Home";
  List urls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2VjovaekyZSpczv4cO9ct9aMsOP1Q3AlTng&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbeJHKbpgZjoQB1kG2_WdFWInI6MAPfOdY3Q&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmQf9vjDicLCVBmAlGahNgbwNnfw2_WC9zgA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmxX2zqZlQoLCGJhDr5Tc-wmqTq8DH2Ux14w&usqp=CAU',
    'https://www.cleaningcompany-riyadh.com/wp-content/uploads/2019/10/Plumber-in-Riyadh-3.jpg',
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
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwJvn3EPBheBSQuw1v0KbDsgN9jsxgSGa5mw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxdWWMQeBbLEaQlNlhGC4WOHyGH-j-xY8QJw&usqp=CAU',
    'https://opensooq-images.os-cdn.com/previews/560x400/77/c9/77c97e88173fe28efedc5e1b28dbc8e5580aecefdc8ee0d3c8b80c57883c4b33.jpg.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7SatoeAq2MOiyW1HWJpzJRZs01zwueccg1Q&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH9i81cbFQLDjbPLXEgHeSvRR2CP32KfwWlw&usqp=CAU',
    'https://cdn.theluxurycloset.com/uploads/optimize/products/full/luxury-kids-ralph-lauren-used-boys-clothing-p79111-001.jpg',
    'https://cdn.pixabay.com/photo/2016/03/08/19/04/car-1244524__340.jpg',
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
    'https://e7.pngegg.com/pngimages/585/816/png-clipart-sofa-bed-couch-chaise-longue-doma-home-furnishings-living-room-chair-angle-furniture.png',
    'https://webimg.secondhandapp.com/1.1/57a1d3a0afa4c5995dccce60',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzi0IFYbYgvQo7Lbb2t07K8i_ilOBNXYx7EQ&usqp=CAU',
    'https://www.shorouknews.com/uploadedimages/Sections/Economy/Market/original/aghezamostamala234.jpg',
    'https://content.avito.ma/images/10/10010778793.jpg',
    'http://wseetk.com/user_images/5660793.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi1tUe4KLxV_MA57Rf9AuzEltDvG-npSfHNQ&usqp=CAU',
    'https://content.avito.ma/images/10/10018192471.jpg',
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
    'https://img.over-blog-kiwi.com/5/06/69/39/20200701/ob_e36298_african-grey-parrots-for-sale.jpg',
    'https://cdn.pixabay.com/photo/2021/01/01/16/38/land-rover-5879202__340.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrJv0OPAFUHLzaJ9kgr010WlwSl39vQHaDMw&usqp=CAU',
    'https://apollo-ireland.akamaized.net/v1/files/pckatvt000ev1-EG/image;s=644x461;olx-st/_5_.jpg',
    'https://opensooq-images.os-cdn.com/previews/300x0/8d/07/8d07c97e76fb2ac64cdf5630a6ca2fe06acc0f47a2d97469b987e85d459d56cb.jpg.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOr5JPeTgu_vM6sMBIrvh4ho6WcVSWdaQi_w&usqp=CAU',
    'https://www.almaal.org/wp-content/uploads/2020/09/%D9%85%D9%88%D9%82%D8%B9-%D8%A8%D9%8A%D8%B9-%D8%B3%D9%8A%D8%A7%D8%B1%D8%A7%D8%AA-%D9%81%D9%8A-%D8%A7%D9%85%D8%B1%D9%8A%D9%83%D8%A7-%D8%B1%D8%AE%D9%8A%D8%B5-1130x580.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgB-3Q9Sb4asyHlCSD1DRqxXL6GSrpvn3hgA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2f0U4sA5OYXC3g6YAnn2ammmKsk6wLy8sOQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOX0DFTxmq8R2mX6BmecgDJdBe3ZMvYGFPhA&usqp=CAU',
    'https://content.avito.ma/images/10/10010585138.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBLnoH3ej__KCKsX4FLncCUAFVZaCPhgBkfA&usqp=CAU',
    'https://services-maintenance-uae.com/wp-content/uploads/2020/05/%D9%86%D8%AC%D8%A7%D8%A7.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST-IZpFnblDuuTxwy22yJLfTnRlALNhxb7kQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc0AyWJjL4ZWtsA8F3nHQQke3D-3xCCsEbug&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4ETAlbMQPwD0NsUkVVRxmKVJJwKcMe-X-qA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXwx4PS3Ghh6Ev1Z9d0WqyvLBz1ZG_m51Ezg&usqp=CAU',
  ];

  List urlsCars = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbeJHKbpgZjoQB1kG2_WdFWInI6MAPfOdY3Q&usqp=CAU',
    'https://www.motortrend.com/uploads/sites/5/2014/10/2012-Honda-Accord-SE-sedan-front-three-quarter.jpg',
    'https://cdn.pixabay.com/photo/2016/03/08/19/04/car-1244524__340.jpg',
    'https://cdn.pixabay.com/photo/2020/01/16/20/48/renault-4771773__340.png',
    'https://cdn.pixabay.com/photo/2017/09/03/16/58/car-2711177__340.jpg',
    'https://cdn.pixabay.com/photo/2016/04/17/21/43/jeep-1335619__340.jpg',
    'https://cdn.pixabay.com/photo/2021/01/01/16/38/land-rover-5879202__340.jpg',
    'https://www.almaal.org/wp-content/uploads/2020/09/%D9%85%D9%88%D9%82%D8%B9-%D8%A8%D9%8A%D8%B9-%D8%B3%D9%8A%D8%A7%D8%B1%D8%A7%D8%AA-%D9%81%D9%8A-%D8%A7%D9%85%D8%B1%D9%8A%D9%83%D8%A7-%D8%B1%D8%AE%D9%8A%D8%B5-1130x580.jpg',
  ];

  List urlsClothes = [
    'https://cdn.theluxurycloset.com/uploads/optimize/products/full/luxury-kids-ralph-lauren-used-boys-clothing-p79111-001.jpg',
    'https://apollo-ireland.akamaized.net/v1/files/pckatvt000ev1-EG/image;s=644x461;olx-st/_5_.jpg',
    'https://www.thebalancesmb.com/thmb/0NefRBrg_lU-vxqzclEne4RU3R8=/640x360/smart/filters:no_upscale()/dressshoes1-f5db6a43f1714b609c772f6c0c1814df.jpg',
    'https://p0.pikist.com/photos/814/525/footwear-men-s-shoes-black-shoes.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO8Xhjc8urY1Zo7zv6QoDIDQ6lMGiPv9bYwg&usqp=CAU',
  ];

  List urlsAnimals = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgB-3Q9Sb4asyHlCSD1DRqxXL6GSrpvn3hgA&usqp=CAU',
    'https://www.inverness-courier.co.uk/_media/img/750x0/HQU1244SU1XHLL8RMMEB.jpg',
    'https://i.pinimg.com/originals/78/81/bf/7881bf62ac85a752263143028f1124b5.jpg',
    'https://i.pinimg.com/originals/ed/51/a2/ed51a299eba6ec3a295cb63799a0417e.jpg',
    'https://cdn11.bigcommerce.com/s-vwd6a/images/stencil/2048x2048/products/604/3563/parrotlet_blue__41318.1571248358.jpg?c=2',
    'https://img.over-blog-kiwi.com/5/06/69/39/20200701/ob_e36298_african-grey-parrots-for-sale.jpg',
    'https://webimg.secondhandapp.com/1.1/57a1d3a0afa4c5995dccce60',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH9i81cbFQLDjbPLXEgHeSvRR2CP32KfwWlw&usqp=CAU',
  ];

  List urlsAsas = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6Ryf82Cb2kg8Li_ZkH0gfC5HkmFdNkL-cqlSu6efXcNiFZmRSHNI-0jo60S_iwx3MwY8BFpc&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMY7yXRnDhd153tj6lRBv6YXDb91cKeKdqWA&usqp=CAU',
    'https://content.avito.ma/images/10/10010778793.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7SatoeAq2MOiyW1HWJpzJRZs01zwueccg1Q&usqp=CAU',
    'https://e7.pngegg.com/pngimages/585/816/png-clipart-sofa-bed-couch-chaise-longue-doma-home-furnishings-living-room-chair-angle-furniture.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOr5JPeTgu_vM6sMBIrvh4ho6WcVSWdaQi_w&usqp=CAU',
    'https://img1.ouedkniss.com/photos_annonces/25706131/Photo1.jpg',
  ];

  List urlsElectricDevices = [
    'https://opensooq-images.os-cdn.com/previews/300x0/8d/07/8d07c97e76fb2ac64cdf5630a6ca2fe06acc0f47a2d97469b987e85d459d56cb.jpg.jpg',
    'https://1.bp.blogspot.com/-VuLYkiFm41o/XTlggPkNqXI/AAAAAAAAABI/1Uu1RopU2sglPQiZ33_KCj40xIVEtCJNQCLcBGAs/s1600/3beeae1c-5811-425f-89c0-1821ef9ecf61.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQebbQSHmkjeAZi6TfnG5FCjaaaXE-dmzyoA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxdWWMQeBbLEaQlNlhGC4WOHyGH-j-xY8QJw&usqp=CAU',
    'http://wseetk.com/user_images/5660793.jpg',
    'https://www.shorouknews.com/uploadedimages/Sections/Economy/Market/original/aghezamostamala234.jpg',
    'https://opensooq-images.os-cdn.com/previews/560x400/77/c9/77c97e88173fe28efedc5e1b28dbc8e5580aecefdc8ee0d3c8b80c57883c4b33.jpg.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzi0IFYbYgvQo7Lbb2t07K8i_ilOBNXYx7EQ&usqp=CAU',
  ];

  List urlsgames = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl3mE_RMsOu0ueZ1NmIa0hsdbNTE8Z6NJan8mCJ6x_CiohUL36DfcTjp-I-hg&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2T7JSYjV9a6M61g2aI0Bqr0aN5Tm-Q51UcbryfilNFAIcpHnYSyVhZQamDBg&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRahYRsn_70I15f9tWEEOT8V8w9subSUeiyQ4Hqc1k8FcH5Tbsu_61CFNxoIlUDYmC7n1ht749s&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXOot-fOsgB1F-SbN9cmo6FycyyMBaGU2EDpo9adXChrysAroKiAizrNgxb2H-glY08Td0OBR_&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPaf6EZvTG7jJ4BamjuO7di8sHCdLz2WEBMviDFlUigovetZ8iAjTnmPUDVA&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsw1cmBNAvLSVIG9WgLtoqnMJypzgJdigLCqrHWYZw3MpD43Yz3UYUdV4zbX-sYg0Pyp735SA&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaACpI7bWPgsPp3LkEyWOegUtrS1MVX7toF20jtMafMv7od0P3i1QZQmlePdqMZNX-dbpFNBR1&usqp=CAc',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcfFO6vElcocqEW4GgdL8_rmDF8q8YGjItX6Z0j2NjSE-39f-LfdjXKqjzTt8Mei1brkgL-cN5&usqp=CAc',
  ];

  List urlsBooks = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHT__g2qt75-avu-97gLQ02CQ0MTJVrGnZKA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmxX2zqZlQoLCGJhDr5Tc-wmqTq8DH2Ux14w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuK2hFNkWSyawRdEVauV8fUccTeFOvgCAvsA&usqp=CAU',
    'https://content.avito.ma/images/10/10018192471.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOX0DFTxmq8R2mX6BmecgDJdBe3ZMvYGFPhA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKF92O1GQNO2DR_t-fxFr5hOmQzRCveBPIxQ&usqp=CAU',
    'https://argaamplus.s3.amazonaws.com/aacce10a-735e-473f-97ca-90445ddc9903.jpg',
    'https://content.avito.ma/images/10/10018192643.jpg',
  ];

  List urlsMobiles = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6LzgrlxDmE4G24tJjkiL2vgDQuwqezpN_QA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpv_ZEIiEzM_mk3jv0QnW_AsjicMxubtQBUw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrJv0OPAFUHLzaJ9kgr010WlwSl39vQHaDMw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2VjovaekyZSpczv4cO9ct9aMsOP1Q3AlTng&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkPhmAtW9kftRP3GBxB0EwoPXBPZLBxamFHw&usqp=CAU',
    'https://content.avito.ma/images/10/10010585138.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwJvn3EPBheBSQuw1v0KbDsgN9jsxgSGa5mw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXBQHXqPjdssAJ_xwurZN3WhJNa18FQq8Q9g&usqp=CAU',
  ];

  List urlsFree = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcfFO6vElcocqEW4GgdL8_rmDF8q8YGjItX6Z0j2NjSE-39f-LfdjXKqjzTt8Mei1brkgL-cN5&usqp=CAc',
    'https://i.pinimg.com/originals/ed/51/a2/ed51a299eba6ec3a295cb63799a0417e.jpg',
    'https://img.over-blog-kiwi.com/5/06/69/39/20200701/ob_e36298_african-grey-parrots-for-sale.jpg',
    'https://cdn.pixabay.com/photo/2021/01/01/16/38/land-rover-5879202__340.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrJv0OPAFUHLzaJ9kgr010WlwSl39vQHaDMw&usqp=CAU',
    'https://apollo-ireland.akamaized.net/v1/files/pckatvt000ev1-EG/image;s=644x461;olx-st/_5_.jpg',
    'https://opensooq-images.os-cdn.com/previews/300x0/8d/07/8d07c97e76fb2ac64cdf5630a6ca2fe06acc0f47a2d97469b987e85d459d56cb.jpg.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOr5JPeTgu_vM6sMBIrvh4ho6WcVSWdaQi_w&usqp=CAU',
    'https://www.almaal.org/wp-content/uploads/2020/09/%D9%85%D9%88%D9%82%D8%B9-%D8%A8%D9%8A%D8%B9-%D8%B3%D9%8A%D8%A7%D8%B1%D8%A7%D8%AA-%D9%81%D9%8A-%D8%A7%D9%85%D8%B1%D9%8A%D9%83%D8%A7-%D8%B1%D8%AE%D9%8A%D8%B5-1130x580.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgB-3Q9Sb4asyHlCSD1DRqxXL6GSrpvn3hgA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOX0DFTxmq8R2mX6BmecgDJdBe3ZMvYGFPhA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR3Gn2tIlpRL7hrO2shrO34YKERjiShiRJ7w&usqp=CAU',
  ];

  List urlsServices = [
    'https://services-maintenance-uae.com/wp-content/uploads/2020/05/%D9%86%D8%AC%D8%A7%D8%A7.jpg',
    'https://super1number.com/wp-content/uploads/2020/08/%D8%A7%D9%81%D8%B6%D9%84-%D9%86%D8%AC%D8%A7%D8%B1-%D8%A7%D8%A8%D9%88%D8%B8%D8%A8%D9%8A.jpg',
    'https://www.cleaningcompany-riyadh.com/wp-content/uploads/2019/10/Plumber-in-Riyadh-3.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi1tUe4KLxV_MA57Rf9AuzEltDvG-npSfHNQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2f0U4sA5OYXC3g6YAnn2ammmKsk6wLy8sOQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR3Gn2tIlpRL7hrO2shrO34YKERjiShiRJ7w&usqp=CAU',
  ];

  List urlsOthers = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST-IZpFnblDuuTxwy22yJLfTnRlALNhxb7kQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmQf9vjDicLCVBmAlGahNgbwNnfw2_WC9zgA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBLnoH3ej__KCKsX4FLncCUAFVZaCPhgBkfA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc0AyWJjL4ZWtsA8F3nHQQke3D-3xCCsEbug&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4ETAlbMQPwD0NsUkVVRxmKVJJwKcMe-X-qA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXwx4PS3Ghh6Ev1Z9d0WqyvLBz1ZG_m51Ezg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7-IV3YpRnewzrc0TcCZkbkMkihZP6DjPXKA&usqp=CAU',
  ];

  List categories = [
    "اخري",
    "خدمات",
    "عناصر مجانية",
    "عربيات",
    "موبايلات",
    "كتب",
    "ألعاب إلكترونية",
    "أجهزة كهربائية",
    "حيوانات",
    "أثاث منزل",
    "ملابس",
    "الكل",
  ];

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: categories.length - 1,
      length: categories.length,
      child: Scaffold(
        endDrawer: DrawerItem(),
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          toolbarHeight: 100,
          leading: IconButton(icon: Icon(Icons.search), onPressed: () {}),
          bottom: PreferredSize(
            preferredSize: Size(0, 10),
            child: Container(
              child: TabBar(
                  isScrollable: true,
                  tabs: categories
                      .map((e) => Text(
                            e,
                            style: GoogleFonts.cairo(),
                          ))
                      .toList()),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsOthers.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsOthers,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),

                    //mainAxisSpacing: 5,

                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsServices.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsServices,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsFree.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsFree,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsCars.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        isFavorite: false,
                        listOfUrl: urlsCars,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsMobiles.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsMobiles,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsBooks.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsBooks,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsgames.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsgames,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsElectricDevices.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsElectricDevices,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsAnimals.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsAnimals,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsAsas.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        isFavorite: false,
                        listOfUrl: urlsAsas,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urlsClothes.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urlsClothes,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ChooseCategoryScreen.route);
                              },
                              child: Icon(
                                Icons.category_outlined,
                                color: Colors.blue[400],
                                size: 40,
                              )),
                          FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Favorites.route);
                              },
                              child: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.blue[400],
                                size: 40,
                              )),
                          FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Recommend.route);
                              },
                              child: Icon(
                                Icons.recommend,
                                color: Colors.blue[400],
                                size: 40,
                              )),
                          FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, MyProducts.route);
                              },
                              child: Icon(
                                Icons.business_center_outlined,
                                color: Colors.blue[400],
                                size: 40,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'الفئات',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'المفضلة',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'مقترح',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'منتجاتى',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: urls.length,

                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, Details.route,
                          arguments: urls[index]),
                      child: ProductItem(
                        index: index,
                        listOfUrl: urls,
                        isFavorite: false,
                      ),
                    ),

                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        2, MediaQuery.of(context).size.aspectRatio * 7.5),
                    //mainAxisSpacing: 5,
                    //crossAxisSpacing: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
