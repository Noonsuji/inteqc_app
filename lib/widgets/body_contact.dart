import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:inteqc_app/models/contract_model.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:inteqc_app/utility/app_service.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyContact extends StatefulWidget {
  const BodyContact({super.key});

  @override
  State<BodyContact> createState() => _BodyContactState();
}

class _BodyContactState extends State<BodyContact> {
  List<ContractModel> allEmployees = [];
  int currentPage = 1;
  final int pageSize = 20;
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadData();
    _scrollController.addListener(() {
      // print(
      //   'Scroll position: ${_scrollController.position.pixels}, max: ${_scrollController.position.maxScrollExtent}',
      // );
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoading &&
          hasMore) {
        //print('Loading next page: $currentPage');
        loadData();
      }
    });
  }

  Future<void> loadData() async {
    final service = AppService();
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final newData = await service.fetchContracts(
        page: currentPage,
        pageSize: pageSize,
        searchQuery: searchQuery,
      );

      setState(() {
        currentPage++;
        allEmployees.addAll(newData);
        if (newData.length < pageSize) hasMore = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredEmployees = allEmployees.where((e) {
      final q = searchQuery.toLowerCase().trim();
      return e.fullName.toLowerCase().trim().contains(q) ||
          e.nickname.toLowerCase().trim().contains(q) ||
          e.OrgName.toLowerCase().trim().contains(q) ||
          e.Phone2.toLowerCase().trim().contains(q);
    }).toList();
    for (var e in allEmployees) {
      debugPrint('FullName: "${e.fullName}"');
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('พนักงาน'),
          titleTextStyle: AppConstant.headStyle(),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ค้นหา',
                  labelStyle: AppConstant.bodyStyle(),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    allEmployees.clear();
                    currentPage = 1;
                    hasMore = true;
                  });
                  loadData();
                },
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: filteredEmployees.length,
                    itemBuilder: (context, index) {
                      final e = filteredEmployees[index];
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Material(
                              type: MaterialType.transparency,
                              child: GFAlert(
                                type: GFAlertType.rounded,
                                content: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              60,
                                            ),
                                            child: Image.asset(
                                              'images/Userman.png',
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Center(
                                          child: Text(
                                            ' ${e.fullName} (${e.nickname})',
                                            style: AppConstant.headStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          ' ${e.OrgName}',
                                          style: AppConstant.bodyStyle(),
                                        ),
                                        Text(
                                          ' ${e.OrgUnitName}',
                                          style: AppConstant.bodyStyle(),
                                        ),
                                        Text(
                                          ' ${e.Email1}',
                                          style: AppConstant.bodyStyle(),
                                        ),
                                        if (e.Phone2.trim().isNotEmpty)
                                          InkWell(
                                            onTap: () =>
                                                _makePhoneCall(e.Phone2),
                                            child: Text(
                                              'โทร: ${e.Phone2}',
                                              style: AppConstant.bodyStyle()
                                                  .copyWith(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                bottomBar: GFButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  text: "ปิด",
                                  textStyle: AppConstant.bodyStyle(),
                                  color: GFColors.PRIMARY,
                                  fullWidthButton: true,
                                  shape: GFButtonShape.pills,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Material(
                          child: Card(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'images/Userman.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    e.fullName,
                                    style: AppConstant.TxtStyle(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Center(
                                    child: Text(
                                      ' (${e.nickname})',
                                      textAlign: TextAlign.center,
                                      style: AppConstant.bodyStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ' ${e.OrgName}',
                                    textAlign: TextAlign.center,
                                    style: AppConstant.bodyStyle(fontSize: 10),
                                  ),
                                  Spacer(),
                                 if (e.Phone2.trim().isNotEmpty) Material(
                                    child: InkWell(
                                      onTap: () => _makePhoneCall(e.Phone2),
                                      child: Text(
                                        'โทร: ${e.Phone2}',
                                        style: AppConstant.bodyStyle().copyWith(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        maxLines: 1,
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
                  ),
                  if (isLoading)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
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
  }

  void _makePhoneCall(String phone2) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone2);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('ไม่สามารถโทรออกได้')));
    }
  }
}
