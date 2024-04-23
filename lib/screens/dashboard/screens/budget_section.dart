import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oraboros/DTO/budget.dto.dart';
import 'package:oraboros/services/budget.service.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:provider/provider.dart';

class BudgetSection extends StatefulWidget {
  const BudgetSection({super.key});

  @override
  State<BudgetSection> createState() => _BudgetSectionState();
}

class _BudgetSectionState extends State<BudgetSection> {
  List<Map<String, dynamic>> _budgetList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    String userId = context.read<ProfileProvider>().profile['id'];
    try {
      List<Map<String, dynamic>> data =
          await BudgetService().getUserBudget(userId);
      setState(() {
        _budgetList = data;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'budgets',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: RefreshIndicator(
        color: const Color(0xff122334),
        onRefresh: fetchData,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              itemCount: _budgetList.length,
              physics: const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff122334),
                        offset: Offset(3, 5),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    style: ListTileStyle.list,
                    visualDensity: VisualDensity.comfortable,
                    leading: Text(
                      _budgetList[index][BudgetMapKey.icon],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    title: Text(
                      _budgetList[index][BudgetMapKey.name],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Text(
                        "Rp. ${NumberFormat.decimalPattern().format(_budgetList[index][BudgetMapKey.amount])}"),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
