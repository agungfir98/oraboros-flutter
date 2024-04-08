import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oraboros/DTO/budget.dto.dart';
import 'package:oraboros/components/box_container.dart';
import 'package:oraboros/fetcher/budget.api.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:provider/provider.dart';

class MainSection extends StatefulWidget {
  const MainSection({super.key});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  List<BudgetDTO> _budgetList = [];

  @override
  void initState() {
    super.initState();
    fetchUserBudget();
  }

  fetchUserBudget() async {
    List<BudgetDTO> budgetList = await getUserBudget(
      GetBudgetDTO(
        userId: context.read<ProfileProvider>().profile[ProfileProvider.id],
      ),
    );

    if (mounted) {
      setState(() {
        _budgetList = budgetList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              BoxContainer(
                child: Consumer<ProfileProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1, color: const Color(0xff122334)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  value.profile[ProfileProvider.avatar]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Halo, ${value.profile[ProfileProvider.display_name].toString().split(" ")[0]}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(Icons.settings_outlined),
                          onTap: () =>
                              Navigator.of(context).pushNamed('/settings'),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              BoxContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This month spend",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Rp. 1.500.000",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            "Budgets",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _budgetList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff122334),
                      offset: Offset(3, 4),
                    )
                  ],
                  border: Border.all(
                    color: const Color(0xff122334),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_budgetList[index].name} ${_budgetList[index].icon}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                        "Rp. ${NumberFormat('#,##,000', "id_ID").format(_budgetList[index].amount)}",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
