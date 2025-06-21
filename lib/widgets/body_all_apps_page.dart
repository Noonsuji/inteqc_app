import 'package:flutter/material.dart';
import 'package:inteqc_app/utility/app_constant.dart';

class AllAppsPage extends StatefulWidget {
  final String department;
  final List<String> apps;

  const AllAppsPage({super.key, required this.department, required this.apps});

  @override
  State<AllAppsPage> createState() => _AllAppsPageState();
}

class _AllAppsPageState extends State<AllAppsPage> {
  String searchQuery = '';

  List<String> get filteredApps {
    if (searchQuery.isEmpty) {
      return widget.apps;
    } else {
      return widget.apps
          .where((app) => app.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // สร้าง List<Widget> ด้วย for loop
    List<Widget> appWidgets = [];
    for (var appName in filteredApps) {
      appWidgets.add(
        Container(
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.apps, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              Text(
                appName,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

return GestureDetector(onTap: () => FocusScope.of(context).unfocus(),  // แตะพื้นที่ว่างจะปิด keyboard
    child:  Scaffold(
      appBar: AppBar(title: Text('แอปทั้งหมดของ ${widget.department}'),titleTextStyle: AppConstant.headStyle(),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'ค้นหาแอป...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: appWidgets,
              ),
            ),
          ],
        ),
      ),
    ),
);
  }
}
