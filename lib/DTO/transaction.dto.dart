import 'package:oraboros/DTO/order.dto.dart';

class TransactionDTO {
  static const String nameKey = "name";
  static const String amountKey = "amount";
  static const String budgetId = "budget_id";
  String? name;
  int? amount;
  String? budgetid;

  TransactionDTO({
    this.name,
    this.amount,
    this.budgetid,
  });

  Map<String, dynamic> toJson() {
    return {
      TransactionDTO.nameKey: name,
      TransactionDTO.amountKey: amount,
      TransactionDTO.budgetId: budgetid,
    };
  }
}

class GetUserTransactionDTO {
  String userId;
  static const userIdKey = "user_id";

  GetUserTransactionDTO({required this.userId});

  Map<String, String> toJson() {
    return {GetUserTransactionDTO.userIdKey: userId};
  }
}

class UserTransactions {
  static const String idKey = "id";
  static const String createdAtKey = "created_at";
  static const String userIdKey = "user_id";
  static const String ordersKey = 'orders';

  String id;
  String createdAt;
  String userId;
  List<UserOrderDTO> orders;

  UserTransactions({
    required this.id,
    required this.createdAt,
    required this.orders,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      createdAtKey: createdAt,
      userIdKey: userId,
      ordersKey: orders.map((order) => order.toJson())
    };
  }
}
