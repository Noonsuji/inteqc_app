import 'package:flutter/material.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:inteqc_app/widgets/newsdetailpage.dart';

class BodyNews extends StatefulWidget {
  const BodyNews({super.key});

  @override
  State<BodyNews> createState() => _BodyNewsState();
}

class _BodyNewsState extends State<BodyNews>
    with SingleTickerProviderStateMixin {
  final Map<String, List<String>> categoryImages = {
    'new': ['images/NW1.jpg', 'images/NW2.jpg'],
    'general': ['images/NW3.jpg', 'images/NW4.jpg'],
    'hr': ['images/NW5.jpg'],
  };

  final Map<String, String> categoryTitles = {
    'new': 'ประกาศใหม่',
    'general': 'ประกาศทั่วไป',
    'hr': 'จาก HR',
  };

  final Map<String, String> searchQueries = {
    'new': '',
    'general': '',
    'hr': '',
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('ข่าวสารทั้งหมด'),
            titleTextStyle: AppConstant.headStyle(),
            bottom: TabBar(
              labelStyle: AppConstant.TxtStyle(
                fontSize: 14,
                color: const Color(0xFFA21D21),
              ), // ใช้ Kanit
              // labelColor: Colors.white,
              unselectedLabelColor: const Color.fromARGB(255, 83, 83, 83),

              //indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'ประกาศใหม่'),
                Tab(text: 'ประกาศทั่วไป'),
                Tab(text: 'จาก HR'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildNewsTab('new'),
              _buildNewsTab('general'),
              _buildNewsTab('hr'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsTab(String categoryKey) {
    List<String> allImages = categoryImages[categoryKey]!;
    String query = searchQueries[categoryKey] ?? '';

    List<String> filtered = allImages.where((imgPath) {
      return imgPath.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Column(
      children: [
        // ✅ Search bar
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'ค้นหา',
              labelStyle: AppConstant.bodyStyle(),
              hintText: 'ค้นหาในหมวด ${categoryTitles[categoryKey]}...',
              hintStyle: AppConstant.bodyStyle(),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQueries[categoryKey] = value;
              });
            },
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final imgPath = filtered[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(
                          imagePath: imgPath,
                          title: 'หัวข้อข่าว',
                          summary: 'เนื้อหาย่อ...',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            imgPath,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'หัวข้อข่าว',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16,
                                  fontFamily: 'kanit',
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'เนื้อหาย่อ...',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontFamily: 'kanit',
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'อ่านเพิ่มเติม',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 91, 155, 250),
                                    fontSize: 14,
                                    fontFamily: 'kanit',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
