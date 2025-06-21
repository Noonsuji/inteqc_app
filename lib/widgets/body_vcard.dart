// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';

class BodyVcard extends StatelessWidget {
  final String name = 'สุชาดา อ่วมคง';
  final String position = 'L5';
  final String phone = '+66824465629';
  final String email = 'suchada.noon@gmail.com';
  final String company = 'INTEQC Co., Ltd.';
  final String website = '';
  final String imagePath = 'images/Profileuser.jpg';
  const BodyVcard({super.key});

  // ✅ vCard 3.0 format
  String get vCardData => '''
BEGIN:VCARD
VERSION:3.0
N:สุชาดา อ่วมคง;;;;
FN:สุชาดา อ่วมคง
ORG:INTEQC Co., Ltd.
TITLE:ICT
TEL;TYPE=WORK,VOICE:+66824465629
EMAIL:suchada.noon@gmail.com
URL:
END:VCARD
''';

  String get vCardContent => vCardData;

  Future<void> _shareVCard(BuildContext context) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/my_vcard.vcf';
      final file = File(filePath);
      await file.writeAsString(vCardContent);

      final xfile = XFile(filePath); // ✅ ไม่ใช่ File()
      await Share.shareXFiles([xfile], text: 'แชร์ข้อมูลติดต่อของฉัน');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('เกิดข้อผิดพลาดในการแชร์: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My VCard', style: AppConstant.headStyle())),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: GFCard(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imagePath,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  name,
                  style: AppConstant.LoginStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  position,
                  style: AppConstant.LoginStyle(fontSize: 16,color: Colors.blue),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone_android_outlined, size: 20, color: Color.fromARGB(221, 0, 108, 9)),
                    const SizedBox(width: 8),
                    Text(phone, style: AppConstant.LoginStyle(fontSize: 16,)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email_outlined, size: 20, color: Color.fromARGB(221, 37, 83, 236)),
                    const SizedBox(width: 8),
                    Text(email, style: AppConstant.LoginStyle(fontSize: 16,)),
                  ],
                ),
                const SizedBox(height: 30),

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: const EdgeInsets.all(20),
                        child: Center(
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: QrImageView(
                                    data: vCardData,
                                    size: 300,
                                    backgroundColor: Colors.white,
                                    
                                  ),
                                  
                                ),
                                
                                // ✅ ปุ่มปิดภายใน Card
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).pop(),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[200],
                                      ),
                                      
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(Icons.close, size: 20),
                                      
                                    ),
                                    
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          QrImageView(
                            data: vCardData,
                            size: 200,
                            backgroundColor: Colors.white,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 4),
                              ],
                            ),
                            padding: const EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                'images/inteqclogo2.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Text('สแกน QR เพื่อเพิ่มข้อมูลติดต่อ', style: AppConstant.LoginStyle(fontSize: 14)),

                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => _shareVCard(context),
                  icon: const Icon(Icons.share),
                  label: Text('แชร์ vCard', style: AppConstant.LoginStyle()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
