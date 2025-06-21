import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:inteqc_app/utility/app_controller.dart';
import 'package:inteqc_app/widgets/body_vcard.dart';
import 'package:inteqc_app/widgets/body_webviewpage.dart';

import 'package:url_launcher/url_launcher.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({super.key});

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  AppController appController = Get.put(AppController());

  Future<void> _launchEmailApp() async {
    const String outlookAndroidScheme = 'ms-outlook://'; // บางเครื่องรองรับ
    const String outlookAndroidPackage = 'com.microsoft.office.outlook';

    // ใช้ launchUrl ถ้า scheme ทำงาน
    if (await canLaunchUrl(Uri.parse(outlookAndroidScheme))) {
      await launchUrl(Uri.parse(outlookAndroidScheme));
    } else {
      // fallback เปิดแอปด้วย package (Android เท่านั้น)
      final Uri uri = Uri(
        scheme: 'intent',
        path: '/',
        queryParameters: {'package': outlookAndroidPackage},
      );

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        debugPrint('ไม่พบแอป Outlook บนเครื่องนี้');
      }
    }
  }

  final List<Map<String, String>> menuItems = [
    {'icon': 'images/help-desk.png', 'label': 'แจ้งซ่อม'},
    {'icon': 'images/meeting-room.png', 'label': 'จองห้องประชุม'},
    {'icon': 'images/ess.png', 'label': 'ess'},
    {'icon': 'images/driving-license.png', 'label': 'Vcard'},
    {'icon': 'images/google-forms.png', 'label': 'E-Form'},
    {'icon': 'images/bad-feedback.png', 'label': 'ร้องเรียน'},
    {'icon': 'images/icommailapplication.png', 'label': 'Email'},
    {'icon': 'images/iconstore.png', 'label': 'Shop'},
  ];
  List<Widget> buildMenuPages() {
    const itemsPerPage = 6;
    int pageCount = (menuItems.length / itemsPerPage).ceil();

    return List.generate(pageCount, (pageIndex) {
      final start = pageIndex * itemsPerPage;
      final end = (start + itemsPerPage > menuItems.length)
          ? menuItems.length
          : start + itemsPerPage;
      final pageItems = menuItems.sublist(start, end);

      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: pageItems.map<Widget>((item) {
          return _buildMenuItemWithImage(item['icon']!, item['label']!);
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageList = [
      AssetImage('images/SL1.jpg'),
      AssetImage('images/SL2.jpg'),
      AssetImage('images/SL3.jpg'),
      AssetImage('images/SL4.jpg'),
      AssetImage('images/SL5.jpg'),
    ];
    final newsImages = [
      'images/NW1.jpg',
      'images/NW2.jpg',
      'images/NW3.jpg',
      'images/NW4.jpg',
      'images/NW5.jpg',
    ];

    //const newsHeight = 100.0;

    return SingleChildScrollView(
      child: Column(
        children: [
          //const SizedBox(height: 1),
          // ---------- Image Slider ----------
          CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 16 / 9,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            items: imageList.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    //borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imageUrl.assetName,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 16),
          const SizedBox(height: 16),

          // ---------- ตัวอย่างเนื้อหาอื่น ๆ ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 260, // กำหนดความสูงของ PageView
              child: PageView(children: buildMenuPages()),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ข่าวสารบริษัท',
                  style: AppConstant.headStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    appController.indexBody.value = 1;
                  },
                  child: Text(
                    'แสดงทั้งหมด>>',
                    style: AppConstant.TxtStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 0, 98, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print('ไปที่ข่าว: ${newsImages[index]}');
                  },
                  child: Container(
                    width: 150.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(newsImages[index], fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemWithImage(String imagePath, String label) {
    return InkWell(
      onTap: () {
        switch (label) {
          case 'แจ้งซ่อม':
            // Navigator.push(context, MaterialPageRoute(builder: (_) => BodyRepair()));
            break;
          case 'จองห้องประชุม':
            // Navigator.push(context, MaterialPageRoute(builder: (_) => BodyMeeting()));
            break;
          case 'Email':
            _launchEmailApp();
            break;
          case 'ess':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BodyWebviewpage(url: 'https://flutter.dev/'),
              ),
            );
            break;
            case 'Vcard':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BodyVcard()),
            );
            break;
          default:
            debugPrint('ยังไม่ได้กำหนดหน้าสำหรับ: $label');
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, width: 48, height: 48),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppConstant.TxtStyle(
              fontSize: 14,
              color: const Color.fromARGB(255, 52, 52, 52),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
