import 'package:flutter/material.dart';
import 'package:inteqc_app/utility/app_constant.dart';

class NewsDetailPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String summary;

  const NewsDetailPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายละเอียด',),titleTextStyle: AppConstant.headStyle(),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'kanit',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    summary,
                    style: const TextStyle(fontSize: 16, fontFamily: 'kanit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
