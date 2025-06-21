class ContractModel {
  final String fullName;
  final String nickname;
  final String department;
  final String empCode;

  ContractModel({
    required this.fullName,
    required this.nickname,
    required this.department,
    required this.empCode,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      fullName: json['FullFLname'] ?? '',
      nickname: json['NickName'] ?? '',
      department: json['OrgUnitTypeName'] ?? '',
      empCode: json['EmpCode'] ?? '',
    );
  }
}
//สุชาดา
