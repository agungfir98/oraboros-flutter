// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

class BudgetMapKey {
  static const String id = "id";
  static const String name = "name";
  static const String icon = "icon";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const String userId = "user_id";
  static const String amount = "amount";
}

class BudgetDTO {
  late String id;
  late String name;
  late String icon;
  late String created_at;
  late String? updated_at;
  late String user_id;
  late int amount;

  BudgetDTO({
    required this.id,
    required this.name,
    required this.icon,
    required this.created_at,
    this.updated_at,
    required this.user_id,
    required this.amount,
  });

  factory BudgetDTO.fromJson(Map<String, dynamic> json) {
    return BudgetDTO(
      id: json[BudgetMapKey.id],
      name: json[BudgetMapKey.name],
      icon: json[BudgetMapKey.icon],
      created_at: json[BudgetMapKey.createdAt],
      updated_at: json[BudgetMapKey.updatedAt],
      user_id: json[BudgetMapKey.userId],
      amount: json[BudgetMapKey.amount],
    );
  }

  static List<BudgetDTO> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((budget) => BudgetDTO.fromJson(budget)).toList();
  }
}
