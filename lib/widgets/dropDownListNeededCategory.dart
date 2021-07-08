import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownListNeededCategory extends StatefulWidget {
  bool updateOrAdd;
  Function fun;
  String initCategory;
  String subCategoryType;

  DropDownListNeededCategory(
      {this.updateOrAdd, this.fun, this.initCategory, this.subCategoryType});
  @override
  _DropDownListNeededCategoryState createState() =>
      _DropDownListNeededCategoryState();
}

class _DropDownListNeededCategoryState
    extends State<DropDownListNeededCategory> {
  String category = '—';
  String val = '—';
  bool firstTime = true;

  @override
  void didChangeDependencies() {
    if (firstTime) {
      if (widget.updateOrAdd) {
        category = widget.initCategory;
        val = widget.subCategoryType;
      }
    }
    firstTime = false;
    super.didChangeDependencies();
  }

  List<Widget> _buildSubCategory() {
    List<Widget> widgets = [];
    if (category == "أجهزة كهربائية") {
      widgets.add(Column(
        children: [
          Text("اختر الفئة الفرعية"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButton<String>(
                isExpanded: true,
                value: val,
                style: GoogleFonts.cairo(color: Colors.black54),
                underline: Container(
                  height: 1,
                  color: Colors.blue[400],
                ),
                onChanged: (String newValue) {
                  setState(() {
                    val = newValue;
                  });
                },
                items: <String>[
                  "بوتجاز",
                  "ثلاجة",
                  "تليفزيون",
                  "تليفون",
                  "مروحه",
                  '—',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                        alignment: Alignment.centerRight, child: Text(value)),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ));
    }
    if (category == "أثاث منزل") {
      widgets.add(Column(
        children: [
          Text("اختر الفئة الفرعية"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButton<String>(
                isExpanded: true,
                value: val,
                style: GoogleFonts.cairo(color: Colors.black54),
                underline: Container(
                  height: 1,
                  color: Colors.blue[400],
                ),
                onChanged: (String newValue) {
                  setState(() {
                    val = newValue;
                  });
                },
                items: <String>[
                  "كرسي",
                  "انتريه",
                  "طاولة",
                  "ستاير و سجاد",
                  "غرف",
                  '—',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                        alignment: Alignment.centerRight, child: Text(value)),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ));
    }
    if ((category != "أثاث منزل") && (category != "أجهزة كهربائية")) val = '—';
    widget.fun(category, val);
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("أختر الفئة المراد التبديل بها"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownButton<String>(
              isExpanded: true,
              value: category,
              style: GoogleFonts.cairo(color: Colors.black54),
              underline: Container(
                height: 1,
                color: Colors.blue[400],
              ),
              onChanged: (String newValue) {
                setState(() {
                  category = newValue;
                  widget.updateOrAdd = false;
                });
              },
              items: <String>[
                "اخري",
                "خدمات",
                "عربيات",
                "موبايلات",
                "كتب",
                "ألعاب إلكترونية",
                "أجهزة كهربائية",
                "حيوانات",
                "أثاث منزل",
                "ملابس",
                '—',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                      alignment: Alignment.centerRight, child: Text(value)),
                );
              }).toList(),
            ),
          ),
        ),
        Column(
          children: _buildSubCategory(),
        ),
      ],
    );
  }
}
