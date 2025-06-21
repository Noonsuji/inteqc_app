import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:inteqc_app/utility/app_constant.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  String name = 'สมชาย ใจดี';
  String nickname = 'ชาย';
  String department = 'IT';
  String phone = '0824465629';
  String imagePath = 'images/Profileuser.jpg';

  late TextEditingController nameController;
  late TextEditingController nicknameController;
  late TextEditingController departmentController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: name);
    nicknameController = TextEditingController(text: nickname);
    departmentController = TextEditingController(text: department);
    phoneController = TextEditingController(text: phone);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          titleTextStyle: AppConstant.headStyle(fontSize: 25),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
          elevation: 4, 
          actions: [
            IconButton(
              icon: const Icon(Icons.logout,color: Colors.red,),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("ออกจากระบบเรียบร้อย")),
                );
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: GFCard(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imagePath,
                          width: 250,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField('ชื่อ', nameController),
                    _buildTextField('ชื่อเล่น', nicknameController),
                    _buildTextField('แผนก', departmentController),
                    _buildTextField(
                      'เบอร์',
                      phoneController,
                      TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    GFButton(
                      onPressed: () {
                        setState(() {
                          name = nameController.text;
                          nickname = nicknameController.text;
                          department = departmentController.text;
                          phone = phoneController.text;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("อัปเดตข้อมูลเรียบร้อย"),
                          ),
                        );
                      },
                      text: 'อัปเดตข้อมูล',
                      textStyle: AppConstant.LoginStyle(fontSize: 18),
                      icon: Icon(Icons.save, color: AppConstant.appColorTitels),
                      fullWidthButton: true,
                      color: const Color.fromARGB(255, 255, 204, 0),
                      shape: GFButtonShape.standard,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, [
    TextInputType? type,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        style: AppConstant.LoginStyle(),
        controller: controller,
        keyboardType: type ?? TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppConstant.TxtStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
