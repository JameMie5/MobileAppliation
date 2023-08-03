import 'package:app_project/database/database_helper.dart';
import 'package:app_project/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:app_project/database/model.dart';

class UserStoryPage extends StatefulWidget {
  UserStoryPage({Key? key, required this.dbHelper}) : super(key: key);

  DatabaseHelper dbHelper;

  @override
  State<UserStoryPage> createState() => _UserStoryPageState();
}

class _UserStoryPageState extends State<UserStoryPage> {
  List<Product> products = [];

  late DatabaseHelper dbHelper;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/BG2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                height: 57.6,
                margin:
                    const EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 57.6,
                      width: 57.6,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0x080a0928),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/logo.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchProduct(dbHelper: widget.dbHelper);
                        }));
                      },
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 48, left: 28.8),
                child: Text(
                  'FOOTSALL \n    BOOKING',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 12, top: 50),
                child: DefaultTabController(
                  length: 4,
                  child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 15, right: 15),
                      indicatorColor: Colors.blue,
                      isScrollable: true,
                      labelColor: const Color.fromARGB(255, 255, 255, 255),
                      unselectedLabelColor: Colors.white70,
                      tabs: [
                        Tab(
                          child: Container(
                            child: const Text('ข่าวสารฟุตบอล'),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: const Text('ข่าวสารบอลยุโรป'),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: const Text('ข่าวสารบอลสเปน'),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: const Text('ข่าวสารตารางคะแนน'),
                          ),
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 28, right: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    FittedBox(
                      child: Text(
                        'ข่าวสารทั่วไป',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        'Show All ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20), //
                height: 150,
                child: ListView(
                  primary: false, // กำหนดให้มีการเลื่อน
                  padding: const EdgeInsets.all(10.0), // ระยะห่างของ Container
                  // จำนวนคอลัมน์
                  scrollDirection: Axis.horizontal, // แนวตั้ง
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    Container(
                        width: 230,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/1.jpg',
                            ),
                          ],
                        )),
                    Container(
                        width: 230,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/2.jpg',
                            ),
                          ],
                        )),
                    Container(
                        width: 230,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/3.jpg',
                            ),
                          ],
                        )),
                    Container(
                        width: 230,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/4.jpg',
                            ),
                          ],
                        )),
                    Container(
                        width: 230,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/5.png',
                            ),
                          ],
                        )),
                    Container(
                        width: 230,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/6.png',
                            ),
                          ],
                        )),
                    Container(
                        width: 230,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/7.png',
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
