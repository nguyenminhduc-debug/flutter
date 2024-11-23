import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: MyColor.background),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: MyColor.secondary,
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        color: MyColor.primary,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Dang nhap",
                              style: TextStyle(
                                  color: MyColor.primary,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "|",
                          style: TextStyle(
                              color: MyColor.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Dang ky",
                              style: TextStyle(
                                  color: MyColor.primary,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                color: MyColor.primary,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: const Text('Trang chu '),
                        leading: const Icon(Icons.home),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: Text('Kiem tra don hang'),
                        leading: Icon(Icons.fact_check_sharp),
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
                        // },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: Text('Danh sach yeu thich'),
                        leading: Icon(Icons.heart_broken),
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                        // },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: Text('Quan ly tai khoan'),
                        leading: Icon(Icons.person),
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                        // },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: Text('Tri an khach hang'),
                        leading: Icon(Icons.card_giftcard),
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                        // },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: Text('Hang moi ve'),
                        leading: Icon(Icons.add_reaction_rounded),
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: RichText(
                          text: TextSpan(
                            text: 'Hotline: ',
                            style: TextStyle(color: MyColor.textColor),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '1800 8086',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColor.background)),
                            ],
                          ),
                        ),
                        leading: const Icon(Icons.phone),
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                        // },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: Text('Ho tro'),
                        leading: Icon(Icons.question_answer),
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                        // },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: Text('Dang xuat'),
                        leading: Icon(Icons.logout),
                        //onTap: logout,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Cong ty co phan Minh Duc",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColor.background,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Dia chi: 100 Phan Van Hon, xa Ba Diem, huyen Hoc Mon, tp.HCM",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColor.textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );;
  }
}
