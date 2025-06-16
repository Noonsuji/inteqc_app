import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:inteqc_app/utility/app_controller.dart';
import 'package:inteqc_app/widgets/body_contact.dart';
import 'package:inteqc_app/widgets/body_home.dart';
import 'package:inteqc_app/widgets/body_menu.dart';
import 'package:inteqc_app/widgets/body_news.dart';
import 'package:inteqc_app/widgets/body_profile.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var titles = <String>['Home', 'News', 'Menu', 'Contact', 'Profile'];
  var iconDatas = <IconData>[
    Icons.home,
    Icons.newspaper,
    Icons.apps,
    Icons.contact_mail,
    Icons.person,
  ];
  var bodys = <Widget>[
    BodyHome(),
    BodyNews(),
    BodyMenu(),
    BodyContact(),
    BodyProfile(),
  ];
  AppController appController = Get.put(AppController());
  List<BottomNavigationBarItem> items = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < bodys.length; i++) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(
            iconDatas[i],
            size: i == 2 ? 50 : 27, // ปุ่ม Menu ใหญ่ขึ้น
         
          ),
          label: titles[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: Text(titles[appController.indexBody.value])),
        body: bodys[appController.indexBody.value],
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: appController.indexBody.value,
          selectedItemColor: AppConstant.appColor,
          selectedIconTheme: IconThemeData(size: 50),
          unselectedIconTheme: IconThemeData(size: 27), // 👈 ขนาดไอคอนอื่น
          selectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          unselectedItemColor: Colors.grey,
          onTap: (value) {
            appController.indexBody.value = value;
          },
        ),
      ),
    );
  }
}
