// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:inteqc_app/widgets/body_all_apps_page.dart';

class BodyMenu extends StatefulWidget {
  const BodyMenu({super.key});

  @override
  State<BodyMenu> createState() => _BodyMenuState();
}

class _BodyMenuState extends State<BodyMenu> {
  final Map<String, List<String>> departmentApps = {
    'HR': ['Leave', 'Recruit', 'Training', 'Benefit', 'Policy', 'Welfare'],
    'ICT': [
      'Helpdesk',
      'Intranet',
      'E-mail',
      'VPN',
      'Cloud',
      'Server',
      'Backup',
      'IT Policy',
    ],
    'Engineer': [
      'Drawing',
      'PM Plan',
      'Tool Tracking',
      'Inventory',
      'Machine Info',
    ],
  };

  String searchKeyword = '';

  @override
  Widget build(BuildContext context) {
    final allApps = departmentApps.entries
        .expand(
          (entry) =>
              entry.value.map((app) => {'department': entry.key, 'app': app}),
        )
        .toList();

    final filteredApps = allApps
        .where(
          (e) => e['app']!.toLowerCase().contains(searchKeyword.toLowerCase()),
        )
        .toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 ช่องค้นหา
            TextField(
              decoration: InputDecoration(
                labelText: 'ค้นหา',
                labelStyle: AppConstant.bodyStyle(),
                hintText: 'ค้นหา Application',
                hintStyle: AppConstant.bodyStyle(),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchKeyword = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // ✅ ถ้ามีการพิมพ์ → แสดงเฉพาะผลลัพธ์ที่ค้นเจอ
            if (searchKeyword.isNotEmpty)
              ...filteredApps.map((e) {
                return ListTile(
                  leading: const Icon(Icons.apps, color: Colors.blue),
                  title: Text(e['app']!),
                  titleTextStyle: AppConstant.headStyle(),
                  subtitle: Text(e['department']!),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('เปิด: ${e['app']} (${e['department']})'),
                      ),
                    );
                  },
                );
              }).toList()
            // ✅ ถ้ายังไม่พิมพ์อะไร → แสดงแผนกแบบปกติ
            else
              ...departmentApps.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: _buildDepartmentSection(entry.key, entry.value),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentSection(String department, List<String> apps) {
    final previewApps = apps.take(6).toList(); // 2 แถว (3x2)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              department,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AllAppsPage(department: department, apps: apps),
                  ),
                );
              },
              child: Text('ดูทั้งหมด',style: AppConstant.bodyStyle(color: const Color.fromARGB(255, 65, 65, 65)),),
              
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
            children: previewApps.map((appName) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
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
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

