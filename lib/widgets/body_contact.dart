import 'package:flutter/material.dart';

class Employee {
  final String image;
  final String name;
  final String nickname;
  final String department;
  final String phone;

  Employee({
    required this.image,
    required this.name,
    required this.nickname,
    required this.department,
    required this.phone,
  });
}

class BodyContact extends StatefulWidget {
  const BodyContact({super.key});

  @override
  State<BodyContact> createState() => _BodyContactState();
}

class _BodyContactState extends State<BodyContact> {
  final List<Employee> allEmployees = [
    Employee(
      image: 'images/Usergamer.png',
      name: 'สมชาย ใจดี',
      nickname: 'ชาย',
      department: 'IT',
      phone: '0812345678',
    ),
    Employee(
      image: 'images/Userman.png',
      name: 'สมศักดิ์ กล้าหาญ',
      nickname: 'ศักดิ์',
      department: 'HR',
      phone: '0898765432',
    ),
    Employee(
      image: 'images/Userwoman.png',
      name: 'สมหญิง สดใส',
      nickname: 'หญิง',
      department: 'บัญชี',
      phone: '0823456789',
    ),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredEmployees = allEmployees.where((e) {
      final q = searchQuery.toLowerCase();
      return e.name.toLowerCase().contains(q) ||
          e.nickname.toLowerCase().contains(q) ||
          e.department.toLowerCase().contains(q) ||
          e.phone.contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('พนักงาน')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ค้นหา',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 คอลัมน์
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75, // สูงกว่าเดิมเพื่อรูปและข้อความ
              ),
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final e = filteredEmployees[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            e.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          e.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'ชื่อเล่น: ${e.nickname}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'แผนก: ${e.department}',
                          textAlign: TextAlign.center,
                        ),
                        Text('เบอร์: ${e.phone}', textAlign: TextAlign.center),
                      ],
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
}
