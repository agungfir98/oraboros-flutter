import 'package:flutter/material.dart';
import 'package:oraboros/screens/dashboard/bottomsheets/transaction/new_transaction_bottom_sheet.dart';
import 'package:oraboros/screens/dashboard/bottomsheets/new_budget_sheet.dart';
import 'package:oraboros/screens/dashboard/bottomsheets/transaction_filter_sheet.dart';
import 'package:oraboros/screens/dashboard/screens/budget_section.dart';
import 'package:oraboros/screens/dashboard/screens/main_section/main_section.dart';
import 'package:oraboros/screens/dashboard/screens/transaction_section.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentSection = 0;
  @override
  void initState() {
    super.initState();
  }

  final List<Map<String, dynamic>> _sections = [
    {
      "icon": const Icon(Icons.add),
      "navItem": const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), label: "home"),
      "widget": const MainSection(),
      "action": const NewTransactionSheet()
    },
    {
      "icon": const Icon(Icons.attach_money),
      "navItem": const BottomNavigationBarItem(
          icon: Icon(Icons.attach_money_outlined), label: "budget"),
      "widget": const BudgetSection(),
      "action": const NewBudgetSheet()
    },
    {
      "icon": const Icon(Icons.filter_list),
      "navItem": const BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz_outlined), label: "transaction"),
      "widget": const TransactionSection(),
      "action": const TransactionFilter()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.only(right: 10),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: currentSection != 1,
              context: context,
              builder: (BuildContext context) {
                return _sections[currentSection]['action'];
              },
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(width: 2, color: Color(0xff122334)),
          ),
          elevation: 0,
          backgroundColor: Colors.yellow[300],
          child: _sections[currentSection]['icon'],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: const [
            BoxShadow(color: Color(0xff122334), offset: Offset(5, 5)),
          ],
          border: Border.all(color: const Color(0xff122334), width: 1),
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          showUnselectedLabels: false,
          currentIndex: currentSection,
          onTap: (int newIndex) {
            setState(() {
              currentSection = newIndex;
            });
          },
          selectedIconTheme: const IconThemeData(color: Color(0xff122334)),
          selectedFontSize: 10,
          selectedLabelStyle:
              Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
          items: _sections
              .map<BottomNavigationBarItem>((section) => section['navItem'])
              .toList(),
        ),
      ),
      body: SafeArea(
        child: _sections[currentSection]['widget'],
      ),
    );
  }
}
