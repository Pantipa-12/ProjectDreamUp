import 'package:compro/component/buildList.dart';
import 'package:compro/component/coin.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

String? _dropdownValue = "Big";
List<String> dropdownList = ["Big", "Normal", "Small"];
final _formKey = GlobalKey<FormState>();
String textList = "";
List<Widget> listOfWidget = [];

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  late FlutterGifController controller1;

  @override
  void initState() {
    controller1 = FlutterGifController(vsync: this);
    super.initState();
    listOfWidget.add(GestureDetector(
      onTap: () {
        openDialog(context);
      },
      child: Container(
          child: BuildList(
        color: Colors.brown,
        text: "",
        add_btn: true,
      )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Dream Up",
            style: GoogleFonts.marmelad(color: Colors.black, fontSize: 30)),
        actions: const [Coin(imagePath: 'lib/images/coin.png')],
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFf9f6ef),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset(
                "lib/images/house.gif",
              ),
              const SizedBox(height: 30),
              Text("To Do Lists",
                  style:
                      GoogleFonts.marmelad(color: Colors.black, fontSize: 30)),
              const SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: listOfWidget.length,
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  itemBuilder: (context, index) => listOfWidget[index],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFfff0cc),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.sunny,
                  color: Colors.black,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                label: ""),
          ]),
    );
  }

  void openDialog(context) => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setDiaState) => Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: AlertDialog(
                  title: Text("Add To Do List"),
                  content: Container(
                    width: 200,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter Text",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Name can't be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              textList = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              isExpanded: true,
                              buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.black26),
                                  color: Colors.grey),
                              items: dropdownList
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      ))
                                  .toList(),
                              value: _dropdownValue,
                              onChanged: (value) => setState(() {
                                    _dropdownValue = value;
                                  })),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          final isValidForm = _formKey.currentState!.validate();
                          if (isValidForm) {
                            Color color = Colors.brown;

                            if (_dropdownValue == dropdownList[0]) {
                              color = Colors.red;
                            } else if (_dropdownValue == dropdownList[1]) {
                              color = Colors.yellow;
                            } else if (_dropdownValue == dropdownList[2]) {
                              color = Colors.grey;
                            }

                            setState(() {
                              listOfWidget.insert(
                                  listOfWidget.length - 1,
                                  BuildList(
                                      color: color,
                                      text: textList,
                                      add_btn: false));

                              listOfWidget.insert(listOfWidget.length - 1,
                                  SizedBox(height: 10));
                            });

                            Navigator.pop(context);
                            print(listOfWidget.length);
                          }
                        },
                        child: const Text("OK"))
                  ],
                ),
              )));
}
