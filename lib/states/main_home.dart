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
  final hideAppBarFor = [1, 2, 3, 4];

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
          appBar: hideAppBarFor.contains(appController.indexBody.value)
              ? null
              : PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ด้านซ้าย
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'images/iconhuman.png',
                              ),
                              radius: 20,
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'INTEQC MEMBER',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Suchada Aumkong',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // ด้านขวา
                        Stack(
                          children: [
                            Icon(Icons.notifications_none, size: 28),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          body: bodys[appController.indexBody.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                items: List.generate(titles.length, (i) {
                  return BottomNavigationBarItem(
                    icon: Icon(
                      iconDatas[i],
                      size: i == 2 ? 34 : 26, // Menu ใหญ่ขึ้นเล็กน้อยพอเหมาะ
                    ),
                    label: titles[i],
                  );
                }),
                currentIndex: appController.indexBody.value,
                selectedItemColor: AppConstant.appColor,
                unselectedItemColor: Colors.grey,
                selectedIconTheme: const IconThemeData(size: 30),
                unselectedIconTheme: const IconThemeData(size: 24),
                selectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(fontSize: 11),
                onTap: (value) {
                  appController.indexBody.value = value;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
