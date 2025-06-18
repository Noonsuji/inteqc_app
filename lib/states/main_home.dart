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
  final hideAppBarFor = [1, 2, 3];

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
      () => SafeArea(
        child: Scaffold(
          appBar: [1, 2, 3].contains(appController.indexBody.value)
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(75),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 12,
                    title: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // จัด Row ให้อยู่กลางแนวนอน
                      mainAxisSize: MainAxisSize.min, // ขนาดเท่าที่จำเป็น
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'images/iconhuman.png', // ใส่ URL หรือ AssetImage
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'INEQC MEMBER',
                              style: AppConstant.headStyle(
                                fontSize: 16,
                                
                              ),
                            ),
                            Text(
                              'Suchada Aumkong',
                              style: AppConstant.LoginStyle(
                                fontSize: 14,
                                
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            const Icon(
                              Icons.notifications_none,
                              color: Colors.black,
                              size: 32, // เพิ่มขนาดไอคอนแจ้งเตือน
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

          body: bodys[appController.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            currentIndex: appController.indexBody.value,
            selectedItemColor: AppConstant.appColor,
            selectedIconTheme: IconThemeData(size: 50),
            unselectedIconTheme: IconThemeData(size: 27),
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
      ),
    );
  }
}
