import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String nickname;
  final String department;
  final String phone;
  final String imagePath;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.nickname,
    required this.department,
    required this.phone,
    required this.imagePath,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController nicknameController;
  late TextEditingController departmentController;
  late TextEditingController phoneController;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    nicknameController = TextEditingController(text: widget.nickname);
    departmentController = TextEditingController(text: widget.department);
    phoneController = TextEditingController(text: widget.phone);
    imagePath = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('แก้ไขโปรไฟล์')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GFAvatar(
                  backgroundImage: AssetImage(imagePath),
                  shape: GFAvatarShape.circle,
                  size: GFSize.LARGE,
                ),
                const SizedBox(height: 20),
                GFTextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'ชื่อ'),
                ),
                const SizedBox(height: 12),
                GFTextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(labelText: 'ชื่อเล่น'),
                ),
                const SizedBox(height: 12),
                GFTextField(
                  controller: departmentController,
                  decoration: const InputDecoration(labelText: 'แผนก'),
                ),
                const SizedBox(height: 12),
                GFTextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'เบอร์โทร'),
                ),
                const SizedBox(height: 24),
                GFButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'name': nameController.text,
                      'nickname': nicknameController.text,
                      'department': departmentController.text,
                      'phone': phoneController.text,
                      'imagePath': imagePath,
                    });
                  },
                  text: 'บันทึก',
                  fullWidthButton: true,
                  color: GFColors.SUCCESS,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
