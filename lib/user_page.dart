import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myproject/registration.dart';
import 'package:myproject/authorization.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool passenable = true;
  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF89C09F),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 420.0,
              width: 350.0,
              decoration: const BoxDecoration(
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      const Padding(
                      padding: EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0, bottom: 20.0),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 100.0,
                        color: Color(0xFF89C09F),
                      ),
                    ),
                      const Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Text("User Name",
                          style: TextStyle(
                            color:  Colors.black,
                            fontFamily: 'BoldMontserrat',
                            fontSize: 24.0,
                          ),
                      ),
                      ),

                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: SizedBox(
                        width: 280,
                        height: 40,
                        child: FlatButton(
                            child: const Text(
                              'Выйти',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 17,
                                  color: Color(0xFFF3F3F3),
                                  fontWeight: FontWeight.bold),
                            ),
                            color: const Color(0xFF89C09F),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Authorization(),
                            ),
                          ),),
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
                            'Редактировать',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17,
                                color: Color(0xFF89C09F),
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 50.0),
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xFFF3F3F3),
                ),
              ),
            ),
          ),
        ],
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
