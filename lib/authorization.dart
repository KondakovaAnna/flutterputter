import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myproject/registration.dart';

class Authorization extends StatefulWidget {
  Authorization({Key? key}) : super(key: key);
  @override
  State<Authorization> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  bool passenable = true;
  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF89C09F),
      body: Center(
        child: Container(
          height: 600.0,
          width: 350.0,
          decoration: const BoxDecoration(
              color: Color(0xFFF3F3F3),
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset('assets/images/logo2.png', width: 100),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40.0, right: 40.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF89C09F), width: 25.0),
                        ),
                        labelText: 'Логин',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Color(0xFF89C09F),
                            fontWeight: FontWeight.bold),
                        icon: Icon(Icons.account_circle_outlined,
                            size: 40.0, color: Color(0xFF89C09F))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 15.0),
                  child: TextField(
                    obscureText: passenable,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF89C09F), width: 25.0),
                        ),
                        labelText: 'Пароль',
                        labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Color(0xFF89C09F),
                            fontWeight: FontWeight.bold),
                        suffix: IconButton(
                            onPressed: () {
                              //add Icon button at end of TextField
                              setState(() {
                                //refresh UI
                                if (passenable) {
                                  //if passenable == true, make it false
                                  passenable = false;
                                } else {
                                  passenable =
                                      true; //if passenable == false, make it true
                                }
                              });
                            },
                            icon: Icon(
                                passenable == true
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                size: 20.0,
                                color: const Color(0xFF89C09F))),
                        icon: const Icon(Icons.vpn_key_outlined,
                            size: 38.0, color: Color(0xFF89C09F))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: SizedBox(
                    width: 280,
                    height: 40,
                    child: FlatButton(
                        child: const Text(
                          'Войти',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17,
                              color: Color(0xFFF3F3F3),
                              fontWeight: FontWeight.bold),
                        ),
                        color: const Color(0xFF89C09F),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {}),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    width: 280,
                    height: 40,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        side: const BorderSide(
                            width: 2.0, color: Color(0xFF89C09F)),
                      ),
                      child: const Text(
                        'Зарегистрироваться',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17,
                            color: Color(0xFF89C09F),
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Registration())),
                    ),
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

class AuthorizationBody extends StatelessWidget {
  final List<Widget> items;
  const AuthorizationBody(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 11.0, left: 11.0, right: 10.0),
        separatorBuilder: (context, index) => Divider(
          endIndent: 30,
          indent: 30,
          thickness: 2.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) => Padding(
          child: items[i],
          padding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
