import 'package:oraboros/DTO/budget.dto.dart';

class UserOrderDTO {
  static const String idKey = "id";
  static const String nameKey = "name";
  static const String amountKey = "amount";
  static const String userIdKey = "user_id";
  static const String budgetIdKey = "budget_id";
  static const String createdAtKey = "created_at";
  static const String transactionIdKey = "transaction_id";
  static const String budgetsKey = "budgets";

  String? id;
  String? name;
  int? amount;
  String? userId;
  String? budgetId;
  String? createdAt;
  String? transactionId;
  UserBudgetDTO? budgets;

  UserOrderDTO({
    this.id,
    this.name,
    this.amount,
    this.userId,
    this.budgetId,
    this.createdAt,
    this.transactionId,
    this.budgets,
  });

  factory UserOrderDTO.fromJson(Map<String, dynamic> json) {
    return UserOrderDTO(
      id: json[UserOrderDTO.idKey],
      name: json[UserOrderDTO.nameKey],
      amount: json[UserOrderDTO.amountKey],
      userId: json[UserOrderDTO.userIdKey],
      budgetId: json[UserOrderDTO.budgetIdKey],
      createdAt: json[UserOrderDTO.createdAtKey],
      transactionId: json[UserOrderDTO.transactionIdKey],
      budgets: json[UserOrderDTO.budgetsKey] == null
          ? null
          : UserBudgetDTO.fromJson(json[UserOrderDTO.budgetsKey]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) ...{UserOrderDTO.idKey: id},
      if (name != null) ...{UserOrderDTO.nameKey: name},
      if (amount != null) ...{UserOrderDTO.amountKey: amount},
      if (userId != null) ...{UserOrderDTO.userIdKey: userId},
      if (budgetId != null) ...{UserOrderDTO.budgetIdKey: budgetId},
      if (createdAt != null) ...{UserOrderDTO.createdAtKey: createdAt},
      if (transactionId != null) ...{
        UserOrderDTO.transactionIdKey: transactionId
      },
      if (budgets != null) ...{UserOrderDTO.budgetsKey: budgets?.toJson()},
    };
  }
}
