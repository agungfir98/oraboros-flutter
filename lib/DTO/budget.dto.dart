class UserBudgetDTO {
  static const String idKey = "id";
  static const String nameKey = "name";
  static const String iconKey = "icon";
  static const String createdAtKey = "created_at";
  static const String updatedAtKey = "updated_at";
  static const String userIdKey = "user_id";
  static const String amountKey = "amount";

  String? id;
  String? name;
  String? icon;
  String? createdAt;
  String? updatedAt;
  String? userId;
  int? amount;

  UserBudgetDTO({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) ...{UserBudgetDTO.idKey: id},
      if (createdAt != null) ...{UserBudgetDTO.createdAtKey: createdAt},
      if (name != null) ...{UserBudgetDTO.nameKey: name},
      if (icon != null) ...{UserBudgetDTO.iconKey: icon},
      if (amount != null) ...{UserBudgetDTO.amountKey: amount},
      if (updatedAt != null) ...{UserBudgetDTO.updatedAtKey: updatedAt},
      if (userId != null) ...{UserBudgetDTO.userIdKey: userId},
    };
  }

  factory UserBudgetDTO.fromJson(Map<String, dynamic> json) {
    return UserBudgetDTO(
      id: json[UserBudgetDTO.idKey],
      name: json[UserBudgetDTO.nameKey],
      icon: json[UserBudgetDTO.iconKey],
      createdAt: json[UserBudgetDTO.createdAtKey],
      updatedAt: json[UserBudgetDTO.updatedAtKey],
      userId: json[UserBudgetDTO.userIdKey],
      amount: json[UserBudgetDTO.amountKey],
    );
  }
}

class NewBudgetDTO {
  static const String nameKey = "name";
  static const String amountKey = 'amount';
  static const String iconKey = "icon";

  final String name;
  final int amount;
  final String icon;

  NewBudgetDTO({
    required this.name,
    required this.amount,
    required this.icon,
  });

  factory NewBudgetDTO.fromJson(Map<String, dynamic> json) {
    return NewBudgetDTO(
      name: json[NewBudgetDTO.nameKey],
      amount: json[NewBudgetDTO.amountKey],
      icon: json[NewBudgetDTO.iconKey],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      nameKey: name,
      amountKey: amount,
      iconKey: icon,
    };
  }
}
