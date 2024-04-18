import 'package:oraboros/main.dart';

class BudgetService {
  final String budgetTable = "budgets";
  final String userIdKey = "user_id";

  Future<List<Map<String, dynamic>>> getUserBudget(String userId) {
    return supabase
        .from(budgetTable)
        .select()
        .eq(userIdKey, userId)
        .then((value) => value);
  }
}
