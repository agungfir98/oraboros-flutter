import 'package:flutter/material.dart';
import 'package:oraboros/screens/dashboard/ui/budget_section.dart';
import 'package:oraboros/screens/dashboard/ui/main_section.dart';
import 'package:oraboros/screens/dashboard/ui/transaction_section.dart';

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

  List<Map<String, dynamic>> sections = [
    {
      "navItem": const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), label: "home"),
      "widget": const MainSection()
    },
    {
      "navItem": const BottomNavigationBarItem(
          icon: Icon(Icons.attach_money_outlined), label: "budget"),
      "widget": const BudgetSection()
    },
    {
      "navItem": const BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz_outlined), label: "transaction"),
      "widget": const TransactionSection()
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
            print("floating btn");
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(width: 2, color: Color(0xff122334)),
          ),
          elevation: 0,
          backgroundColor: Colors.yellow[300],
          child: const Icon(
            Icons.add,
            color: Color(0xff122334),
          ),
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
          items: sections
              .map<BottomNavigationBarItem>((e) => e['navItem'])
              .toList(),
        ),
      ),
      body: SafeArea(
        child: sections[currentSection]['widget'],
      ),
    );
  }
}
