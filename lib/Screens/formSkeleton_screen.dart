import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/dropDownListLocation.dart';
import 'package:gp_version_01/widgets/dropDownListNeededCategory.dart';
import 'package:gp_version_01/widgets/dropListCategories.dart';
import 'package:gp_version_01/widgets/image_input.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddItemScreen extends StatefulWidget {
  static const String route = '/addItemScreen';

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController c;
  int index;
  bool updateOrAdd = false;
  bool categoriesFlag = false;
  bool isUpdate = true;
  String title;
  String description;
  File imageFile;
  bool condition;
  bool isFree;
  String categoryType = 'كتب';
  String subCategoryType = '—';
  String neededCategory = '—';
  String neededsubCategoryType = '—';
  Map properties = new Map<String, String>();
  List<File> imagesFiles = List<File>();
  List<String> locat = ['', ''];
  bool showSpinner = false;
  bool isLeave = false;
  bool fromOffer = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var initialValues = {
    'title': '',
    'description': '',
    'images': [''],
    'categoryType': 'كتب',
    'subCategoryType': '—',
    'neededCategory': '—',
    'neededSubCategory': '—',
    'properties': {},
    'favoritesUserIDs': [''],
    'location': [''],
    'directory': 0,
  };

  Widget _dropList() {
    return DropListCategories(
      fun,
      properties,
      initialValues['properties'],
      updateOrAdd,
      initialValues['categoryType'],
      initialValues['subCategoryType'],
    );
  }

  Widget _dropListNeededCat() {
    return DropDownListNeededCategory(
      updateOrAdd: updateOrAdd,
      fun: neededCategoryFun,
      initCategory: initialValues['neededCategory'],
      subCategoryType: initialValues['neededSubCategory'],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        isLeave = false;
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("نعم"),
      onPressed: () {
        isLeave = true;
        Navigator.of(context).pop();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    // set up the AlertDialog
    Directionality alert = Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text("تنبيه"),
          content: Text("هل انت متأكد انك تريد الخروج من البرنامج؟"),
          actions: [
            cancelButton,
            continueButton,
          ],
        ));

    // show the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Item item = Item(
    categoryType: 'كتب',
    subCategoryType: '—',
    description: "",
    title: "",
    id: null,
    images: [],
    isFree: null,
    condition: null,
    properties: {},
    neededSubCategory: '—',
    neededCategory: '—',
  );

  @override
  void didChangeDependencies() {
    if (isUpdate) {
      String id = ModalRoute.of(context).settings.arguments as String;
      if (id == "fromOffer") {
        fromOffer = true;
      } else if (id != null) {
        updateOrAdd = true;
        categoriesFlag = true;
        item = Provider.of<ItemController>(context, listen: false).findByID(id);
        index =
            Provider.of<ItemController>(context, listen: false).getIndex(item);
        initialValues['title'] = item.title;
        initialValues['description'] = item.description;
        initialValues['images'] = item.images;
        initialValues['categoryType'] = item.categoryType;
        initialValues['subCategoryType'] = item.subCategoryType;
        initialValues['neededCategory'] = item.neededCategory;
        initialValues['neededSubCategory'] = item.neededSubCategory;
        initialValues['properties'] = item.properties;
        initialValues['id'] = item.id;
        initialValues['favoritesUserIDs'] = item.favoritesUserIDs;
        initialValues['location'] = item.location;
        initialValues['directory'] = item.directory;
      }
      print("------------------------------------------");
      print(item.properties);
    }
    isUpdate = false;
    super.didChangeDependencies();
  }

  void showErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: Text("يجب ان يكون هناك صورة واحده للمنتج على الاقل"),
            title: Text('خطأ'),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(), child: Text('تخطى'))
            ],
          ),
        );
      },
    );
  }

  void fun(String catTemp, String subCatTemp) {
    categoryType = catTemp;
    subCategoryType = subCatTemp;
  }

  void neededCategoryFun(String neededCat, String needsubCatTemp) {
    neededCategory = neededCat;
    neededsubCategoryType = needsubCatTemp;
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          initialValue: initialValues["title"],
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: 'اسم المنتج',
            labelStyle: TextStyle(color: Colors.black54),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
          ),
          maxLength: 30,
          validator: (String value) {
            if (value.isEmpty) {
              return 'اسم المنتج مطلوب';
            }
            return null;
          },
          onSaved: (String value) {
            title = value;
          },
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          initialValue: initialValues["description"],
          maxLines: 3,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: 'الوصف',
            labelStyle: TextStyle(color: Colors.black54),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return 'وصف المنتج مطلوب';
            }
            return null;
          },
          onSaved: (String value) {
            description = value;
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          _buildDescription(),
          _dropList(),
          _dropListNeededCat()
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ImageMultiple(imagesFiles, initialValues['images'], updateOrAdd);
  }

  Widget _dropListLocation() {
    return DropDownListLocation(updateOrAdd, initialValues['location'], locat);
  }

  Widget _buildCondition(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "المزيد",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RadioButtonGroup(
                    labels: <String>[
                      "جديد",
                      "مستعمل",
                    ],
                    onSelected: (String selected) => (selected == 'مستعمل')
                        ? condition = false
                        : condition = true,
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: VerticalDivider(
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RadioButtonGroup(
                    labels: <String>[
                      "بمقابل",
                      "دون مقابل",
                    ],
                    onSelected: (String selected) =>
                        (selected == 'بمقابل') ? isFree = false : isFree = true,
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void save() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    FocusManager.instance.primaryFocus.unfocus();
    if (imagesFiles.length == 0 && !updateOrAdd) {
      showErrorMessage(context);
    } else {
      setState(() {
        showSpinner = true;
      });
      Item item = new Item(
        categoryType: categoryType,
        subCategoryType: subCategoryType,
        neededCategory: neededCategory,
        neededSubCategory: neededsubCategoryType,
        description: description,
        itemOwner: FirebaseAuth.instance.currentUser.uid,
        title: title,
        date: Timestamp.now(),
        imageFiles: imagesFiles,
        condition: condition,
        isFree: isFree,
        location: locat,
        properties: properties,
        directory: initialValues['directory'],
        favoritesUserIDs: initialValues['favoritesUserIDs'],
        images: initialValues['images'],
        id: initialValues['id'],
      );
      if (updateOrAdd) {
        await Provider.of<ItemController>(context, listen: false)
            .updateItem(item, index);

        await Provider.of<ModelController>(context, listen: false)
            .categoryScore(
                Provider.of<ItemController>(context, listen: false).items,
                initialValues['neededCategory'],
                initialValues['neededSubCategory'],
                true);

        if (neededCategory != '—') {
          print("ooooooooooooooooooooooo");
          await Provider.of<ModelController>(context, listen: false)
              .categoryScore(
                  Provider.of<ItemController>(context, listen: false).items,
                  neededCategory,
                  neededsubCategoryType,
                  false);
        }
      } else {
        await Provider.of<ItemController>(context, listen: false).addItem(item);
        await Provider.of<ItemOffersController>(context, listen: false)
            .addItemOffers(item);
        await Provider.of<ModelController>(context, listen: false)
            .addItemToModel(item.id);
        if (neededCategory != '—') {
          await Provider.of<ModelController>(context, listen: false)
              .categoryScore(
                  Provider.of<ItemController>(context, listen: false).items,
                  neededCategory,
                  neededsubCategoryType,
                  false);
        }
      }
      properties.clear();
      setState(() {
        showSpinner = false;
      });
      Toast.show("تم الاضافة بنجاح", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      if (fromOffer) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushNamed(MyProducts.route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return WillPopScope(
      onWillPop: () async {
        if (updateOrAdd || fromOffer) {
          Navigator.of(context).pop();
          return true;
        } else {
          showAlertDialog(context);
          return isLeave;
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          updateOrAdd ? 'تعديل منتج' : "اضف منتج",
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
        )),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            margin: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildImage(),
                  _buildForm(),
                  _dropListLocation(),
                  _buildCondition(context),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        updateOrAdd ? 'تعديل' : 'اضف',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: save,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
