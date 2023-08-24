import 'dart:convert';

import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'Valuta.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ValutaModel> models = [];
  String valutaChange = '0';
  String icon = 'USD';
  String icon2 = 'RUS';
  double a = 0;

  void _getData() async {
    Uri uri = Uri.parse("https://cbu.uz/uz/arkhiv-kursov-valyut/json/");
    Response response = await get(uri);
    List list = jsonDecode(response.body);
    models = list.map((e) => ValutaModel.fromJson(e)).toList();
  }

  void _changedDollar() {
    for (ValutaModel i in models) {
      if (i.ccy == icon) {
        for (ValutaModel j in models) {
          if (j.ccy == icon2) {
            valutaChange = ((a * double.parse(i.rate!)) / double.parse(j.rate!))
                .toString();
            setState(() {});
          }
        }
      }
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFEAEAFE),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Currency Converter",
                  style: TextStyle(color: Color(0xFF1F2261), fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Chek live rates,set rate alerts,receive",
                    style: TextStyle(fontSize: 16, color: Color(0xFF808080)),
                  ),
                ),
                Align(
                  child: Text(
                    "notification and more",
                    style: TextStyle(fontSize: 16, color: Color(0xFF808080)),
                  ),
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 320,
                        height: 350,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 190),
                                child: Text(
                                  "Amount",
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 25),
                                ),
                              ),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleFlag(
                                          '${icon.substring(0, 2)}',
                                          size: 20,
                                        ),),
                                  ),
                                ),
                                DropdownMenu<String>(
                                  initialSelection: "SGD",
                                  dropdownMenuEntries: [
                                    for (final model in models)
                                      DropdownMenuEntry(
                                          value: "${model.ccy}",
                                          label: "${model.ccy}"),
                                  ],
                                  onSelected: (value) {
                                    icon = value!;
                                    _changedDollar();
                                    setState(() {});
                                  },
                                  menuHeight: 100,
                                  width: 100,
                                  inputDecorationTheme: InputDecorationTheme(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  height: 55,
                                  child: Center(
                                    child: TextField(
                                      onChanged: (value) {
                                        a = double.tryParse(value) ?? 0;
                                        _changedDollar();
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFEFEFEF),
                                          ),
                                        ),
                                        fillColor: Color(0xFFEFEFEF),
                                        filled: true,
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'\d')),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                              Stack(
                                children: [
                                  Divider(
                                    height: 50,
                                    color: Colors.yellowAccent,
                                    thickness: 1,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      height: 44,
                                      width: 44,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF26278D),
                                        ),
                                        child: Center(
                                            child: Icon(
                                          CupertinoIcons.arrow_up_arrow_down,
                                          color: Colors.white,
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 120.0),
                                child: Text(
                                  "Converted Amount",
                                  style: TextStyle(
                                      color: Color(0xFF989898), fontSize: 20),
                                ),
                              ),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleFlag(
                                          '${icon2.substring(0, 2)}',
                                          size: 20,
                                        )),
                                  ),
                                ),
                                DropdownMenu<String>(
                                  initialSelection: "USD",
                                  dropdownMenuEntries: [
                                    for (var model in models)
                                      DropdownMenuEntry(
                                        value: "${model.ccy}",
                                        label: "${model.ccy}",
                                      ),
                                  ],
                                  onSelected: (value) {
                                    icon2 = value!;
                                    _changedDollar();
                                    setState(() {});
                                  },
                                  menuHeight: 100,
                                  width: 100,
                                  inputDecorationTheme: InputDecorationTheme(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  height: 55,
                                  child: Center(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: valutaChange,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        fillColor: Color(0xFFEFEFEF),
                                        filled: true,
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'\d')),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:15.0,right: 150),
                  child: Text("Indication Exchange Rate"),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,right: 150),
                child: Text(
                 "1 USD = 10600 so'm", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
