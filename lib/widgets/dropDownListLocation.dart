import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gp_version_01/models/city.dart';

// ignore: must_be_immutable
class DropDownListLocation extends StatefulWidget {
  bool updateOrAdd;
  List<String> init;
  List<String> locat;
  DropDownListLocation(this.updateOrAdd, this.init, this.locat);
  @override
  _DropDownListLocationState createState() => _DropDownListLocationState();
}

class _DropDownListLocationState extends State<DropDownListLocation> {
  String city = '—';
  String district = '—';
  bool firstTime = true;

  List<String> districts = [];
  List<String> cities = [
    '—',
    'القاهرة',
    'الجيزة',
    'الأسكندرية',
    'أسوان',
    'أسيوط',
    'الاقصر',
    'الإسماعلية',
    'البحر الأحمر',
    'البحيرة',
    'الدقهلية',
    'السويس',
    'الشرقية',
    'الغربية',
    'الفيوم',
    'القليوبية',
    'المنوفية',
    'المنيا',
    'الوادي الجديد',
    'بني سويف',
    'بورسعيد',
    'جنوب سيناء',
    'دمياط',
    'سوهاج',
    'قنا',
    'كفر الشيخ',
    'مطروح'
  ];
  List<City> citiesDistricts = [
    City(name: '—', districts: ['—']),
    City(name: 'القاهرة', districts: [
      'الأميرية',
      'البساتين',
      'التبين',
      'الجمالية',
      'الحلمية الجديدة',
      'الدراسة',
      'الدرب الأحمر',
      'الزاوية الحمراء',
      'الزمالك',
      'السيدة زينب',
      'الشرابية',
      'العاصمة الإدارية الجديدة',
      'العباسية',
      'العبور',
      'العتبة',
      'الفسطاط',
      'القاهرة الجديدة - التجمع',
      'القطامية',
      'الماظة',
      'المرج',
      'المطرية',
      'المعادي',
      'المعصره',
      'المقطم',
      'المنيل',
      'الموسكي',
      'النزهة الجديدة',
      'الوايلي',
      'باب الشعرية',
      'بولاق',
      'جاردن سيتي',
      'جسر السويس',
      'حدائق القبة',
      'حدائق حلوان',
      'حلمية الزتون',
      'حلوان',
      'دار السلام',
      'رمسيس',
      'روض الفرج',
      'زهراء المعادي',
      'شبرا',
      'شيراتون',
      'طرة',
      'عزبة النخل',
      'عين شمس',
      'قصر النيل',
      'مدينة 15 مايو',
      'مدينة الرحاب',
      'مدينة السلام',
      'مدينة الشروق',
      'مدينة المستقبل',
      'مدينة بدر',
      'مدينة نصر',
      'مدينتي',
      'مصر الجديدة',
      'مصر القديمة',
      'هليوبوليس الجديدة',
      'وسط القاهرة'
    ]),
    City(name: 'الجيزة', districts: [
      'أكتوبر',
      'أبو رواش',
      'أرض اللواء',
      'أوسيم',
      'إمبابة',
      'البدرشين',
      'البراجيل',
      'الحوامدية',
      'الدقي',
      'الشيخ زايد',
      'الصف',
      'العجوزة',
      'العياط',
      'الكيت كات',
      'المنصورية',
      'المنيب',
      'المهندسين',
      'الهرم',
      'الوراق',
      'بشتيل',
      'بولاق الدكرور',
      'ترسا',
      'جزيرة الدهب',
      'حدائق 6 أكتوبر',
      'حدائق الأهرام',
      'حي الجيزة',
      'دهشور',
      'صفط اللبن',
      'غرب سوميد',
      'فيصل',
      'كرداسة',
      'مركز الجيزة',
      'مريوطية',
      'منيل شيحة',
      'ناهيا'
    ]),
    City(name: 'الأسكندرية', districts: [
      'أبو تلات',
      'أبو قير',
      'الأزاريطة',
      'الإبراهيمية',
      'الجمرك',
      'الحضرة',
      'الدخيلة',
      'السيوف',
      'الصالحية',
      'الظاهرية',
      'العامرية',
      'العصافرة',
      'العطارين',
      'العوايد',
      'القباري',
      'اللبان',
      'المعمورة',
      'المكس',
      'المنتزه',
      'المندرة',
      'المنشية',
      'النخيل',
      'الورديان',
      'باكوس',
      'بحري والأنفوشي',
      'برج العرب',
      'بولكلى',
      'جليم',
      'جناكنيس',
      'رأس التين',
      'رشدي',
      'زيزينيا',
      'سابا باشا',
      'سان ستيفانو',
      'سبورتنج',
      'ستانلى',
      'سموحة',
      'سيدي بشر',
      'سيدي جابر',
      'شاطبي',
      'شدس',
      'عجمي',
      'فلمنج',
      'فيكتوريا',
      'كامب شيزار',
      'كرموز',
      'كفر عبدو',
      'كليوباترا',
      'كوم الدكة',
      'لوران',
      'محرم بيك',
      'محطة الرمل',
      'ميامي'
    ]),
    City(name: 'أسوان', districts: [
      'ابو الريش',
      'ابو سمبل',
      'ادفو',
      'البصيلية',
      'الرديسية',
      'السباعية',
      'دراو',
      'صحاري',
      'كلابشة',
      'كوم امبو',
      'مدينة أسوان',
      'نصر النوبة'
    ]),
    City(name: 'أسيوط', districts: [
      'أبنوب',
      'أبو تيج',
      'أسيوط الجديدة',
      'البداري',
      'الغنايم',
      'الفتح',
      'القوصيه',
      'ديروط',
      'ساحل سليم',
      'صدفا',
      'طيبة الجديدة',
      'مدينة أسيوط',
      'منفلوط'
    ]),
    City(name: 'الاقصر', districts: [
      'أرمنت',
      'إسنا',
      'البياضية',
      'الزينية',
      'الطود',
      'القرنه',
      'مدينة الأقصر'
    ]),
    City(name: 'الإسماعلية', districts: [
      'أبو صوير',
      'التل الكبير',
      'القصاصين',
      'القنطرة شرق',
      'القنطرة غرب',
      'فايدة',
      'مدينة الإسماعيلية'
    ]),
    City(name: 'البحر الأحمر', districts: [
      'الجولة',
      'الغردقة',
      'القصير',
      'حلايب وشلاتين',
      'رأس غارب',
      'سفاجا',
      'سهل حشيش',
      'مرسي علم'
    ]),
    City(name: 'البحيرة', districts: [
      'ابو المطامير',
      'ابو حمص',
      'إدكو',
      'الدلنجات',
      'الرحمانية',
      'المحمودية',
      'النوبارية الجديدة',
      'ايتاي البارود',
      'حوش عيسي',
      'دمنهور',
      'رشيد',
      'شبراخيت',
      'كفر الدوار',
      'كوم حمادة',
      'مركز بدر',
      'وادي النطرون'
    ]),
    City(name: 'الدقهلية', districts: [
      'أجا',
      'أخطاب',
      'السنبلاوين',
      'الكردي',
      'المنزلة',
      'المنصورة',
      'المنصورة الجديدة',
      'بلقاس',
      'بني عبيد',
      'تمي الامديد',
      'جمصه',
      'دكرنس',
      'شربين',
      'طلخا',
      'مركز الجمالية',
      'مركز المطرية',
      'مدينة النصر',
      'ميت سلسيل',
      'ميت غمر',
      'نبروه'
    ]),
    City(name: 'السويس', districts: [
      'العين السخنة',
      'حي الجناين',
      'حي فيصل',
      'حي الأربعين',
      'حي السويس',
      'حي عتاقة'
    ]),
    City(name: 'الشرقية', districts: [
      'أبو حماد',
      'أبو كبير',
      'أولاد صقر',
      'الإبراهمية',
      'الحسينية',
      'الزقازيق',
      'الصالحية الجديدة',
      'العاشر من رمضان',
      'القرين',
      'القنايات',
      'بلبيس',
      'ديرب نجم',
      'فاقوس',
      'كفر صقر',
      'مشتول السوق',
      'منيا القمح',
      'ههيا'
    ]),
    City(name: 'الغربية', districts: [
      'السنطة',
      'المحلة الكبري',
      'بسيون',
      'زفتي',
      'سمنود',
      'طنطا',
      'قطور',
      'كفرالزيات'
    ]),
    City(name: 'الفيوم', districts: [
      'أطسا',
      'إبشواي',
      'الفيوم الجديدة',
      'سنورس',
      'طامية',
      'مدينة الفيوم',
      'يوسف الصديق'
    ]),
    City(name: 'القليوبية', districts: [
      'الخانكة',
      'الخصوص',
      'القناطر الخيرية',
      'بنها',
      'بهتيم',
      'شبرا الخيمة',
      'شبين القناطر',
      'طوخ',
      'قليوب',
      'قها',
      'كفر شكر',
      'مسطرد'
    ]),
    City(name: 'المنوفية', districts: [
      'أشمون',
      'الباجور',
      'السادات',
      'الشهداء',
      'بركة السبع',
      'تلا',
      'سرس الليان',
      'شبين الكوم',
      'قويسنا',
      'منوق'
    ]),
    City(name: 'المنيا', districts: [
      'ابو قرقاص',
      'العدوة',
      'المنيا الجديدة',
      'بني مزار',
      'دير مواس',
      'سمالوط',
      'مدينة المنيا',
      'مطاوي',
      'مغاغة',
      'ملوي'
    ]),
    City(name: 'الوادي الجديد', districts: [
      'الخارجة',
      'الداخلة',
      'الفرافرة',
      'باريس',
      'بلاط',
      'مدينة موط'
    ]),
    City(name: 'بني سويف', districts: [
      'إهناسيا',
      'الفشن',
      'الواسطي',
      'ببا',
      'بني سويف الجديدة',
      'سمسطا',
      'مدينة بني سويف',
      'ناصر'
    ]),
    City(name: 'بورسعيد', districts: [
      'حي الجنوب',
      'حي الزهور',
      'حي الشرق',
      'حي الضواحي',
      'حي العرب',
      'حي المناخ',
      'مدينة بورفؤاد'
    ]),
    City(name: 'جنوب سيناء', districts: [
      'أبو رديس',
      'أبو زنيمة',
      'دهب',
      'راس سدر',
      'سانت كاترين',
      'شرم الشيخ',
      'طابا',
      'طور سيناء',
      'نوبيع'
    ]),
    City(name: 'دمياط', districts: [
      'الزرقا',
      'السرو',
      'دمياط الجديدة',
      'رأس البر',
      'عزبة البرج',
      'فارسكور',
      'كفر البطيخ',
      'كفر سعد',
      'مدينة دمياط',
      'مركز الوضة',
      'ميت أبو غالب'
    ]),
    City(name: 'سوهاج', districts: [
      'أخميم',
      'البلينا',
      'العسيرات',
      'المراعة',
      'المنشاة',
      'جرجا',
      'ساقلتة',
      'سوهاج الجديدة',
      'طما',
      'طهطا',
      'مركز جهينة',
      'مركز دار السلام',
      'مركز سوهاج'
    ]),
    City(name: 'قنا', districts: [
      'أبو تشت',
      'الوقف',
      'دشنا',
      'فرشوط',
      'قفط',
      'قوص',
      'مدينة قنا',
      'نجع حمادي',
      'نقادة'
    ]),
    City(name: 'كفر الشيخ', districts: [
      'البرلس',
      'الحامول',
      'الرياض',
      'بلطيم',
      'بيلا',
      'دسوق',
      'سيدي سالم',
      'فوه',
      'قلين',
      'مدينة كفر الشيخ',
      'مطوبس'
    ]),
    City(name: 'مطروح', districts: [
      'الحمام',
      'الساحل الشمالى',
      'السلوم',
      'الضبعة',
      'العلمين',
      'النجيلة',
      'براني',
      'سيوة',
      'مرسي مطروح'
    ]),
  ];

  List<String> getDistricts(String city) {
    List<String> temp = [];
    int index = citiesDistricts.indexWhere((element) => element.name == city);
    temp = citiesDistricts[index].districts;
    return temp;
  }

  @override
  void didChangeDependencies() {
    if (firstTime) {
      if (widget.updateOrAdd) {
        city = widget.init[0];
        district = widget.init[1];
        widget.locat[0] = widget.init[0];
        widget.locat[1] = widget.init[1];
      }
      districts = getDistricts(city);
    }
    firstTime = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    districts = getDistricts(city);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Text('أختر المكان'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: DropdownButton<String>(
                    //isExpanded: true,
                    value: city,
                    style: GoogleFonts.cairo(color: Colors.black54),
                    underline: Container(
                      height: 1,
                      color: Theme.of(context).accentColor,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        city = newValue;
                        widget.locat[0] = city;
                        widget.init.clear();
                        widget.updateOrAdd = false;
                        districts = getDistricts(city);
                        district = districts[0];
                        widget.locat[1] = district;
                      });
                    },
                    items: cities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                            alignment: Alignment.centerRight, child: Text(value)),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, left: 8.0, top: 8.0, right: 30),
                  child: DropdownButton<String>(
                    //isExpanded: true,
                    value: district,
                    style: GoogleFonts.cairo(color: Colors.black54),
                    underline: Container(
                      height: 1,
                      color: Theme.of(context).accentColor,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        district = newValue;
                        widget.locat[1] = district;
                        widget.init.clear();
                        widget.updateOrAdd = false;
                      });
                    },
                    items:
                        districts.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                            alignment: Alignment.centerRight, child: Text(value)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
