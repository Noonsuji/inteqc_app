// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContractModel {
  final String fullName;
  final String nickname;
  final String OrgName;
  final String Phone2;
  final String OrgUnitName;
  final String Email1;
  final String Department;

  ContractModel({
    required this.fullName,
    required this.nickname,
    required this.OrgName,
    required this.Phone2,
    required this.OrgUnitName,
    required this.Email1,
    required this.Department,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      fullName: json['fullname'] ?? '',
      nickname: json['NickName'] ?? '',
      OrgName: json['OrgName'] ?? '',
      Phone2: json['Phone2'] ?? '',
      OrgUnitName: json['OrgUnitName'] ?? '',
      Email1: json['Email1'] ?? '',
      Department: json['Department'] ?? '',
    );
  }
}

