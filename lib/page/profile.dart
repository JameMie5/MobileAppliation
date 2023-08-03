import 'package:app_project/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:app_project/database/model.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key, required this.dbHelper}) : super(key: key);

  DatabaseHelper dbHelper;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<Product> products = [];

  late DatabaseHelper dbHelper;

  String _name = '', _description = '', _datetime = '',_telphone = '', _time = '';
  final int _pay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/BG3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Center(
                  child: Text(
                    'จองคิวสนามฟุตซอล',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: TextFormField(
                      initialValue: '',
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: ' ชื่อ-นามสกุล',
                        hintText: ' กรุณากรอกชื่อ-นามสกุล...',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: TextFormField(
                      initialValue: ' สนามกีฬาที่ ',
                      decoration: const InputDecoration(
                        labelText: ' สนามกีฬา',
                        hintText: ' กรุณากรอกสนามกีฬา...',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _description = value;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: TextFormField(
                      initialValue: '',
                      decoration: const InputDecoration(
                        labelText: ' วันที่',
                        hintText: ' กรุณากรอกวันที่...',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _datetime = value;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: TextFormField(
                      initialValue: '',
                      decoration: const InputDecoration(
                        labelText: ' เวลา',
                        hintText: ' กรุณากรอกเวลา...',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _time = value;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: TextFormField(
                      initialValue: '',
                      decoration: const InputDecoration(
                        labelText: ' เบอร์โทร',
                        hintText: ' กรุณากรอกเบอร์โทร...',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _telphone = value;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(18),
                    child: ElevatedButton(
                        child: const Text('เพิ่มข้อมูล',
                            style: TextStyle(color: Colors.white,
                            fontSize: 18),),
                        onPressed: () async {
                          var newProduct = Product(
                              name: _name,
                              description: _description,
                              telphone: _telphone,
                              datetime: _datetime,
                              time: _time,
                              pay: _pay,
                              referenceId: null);
                          await widget.dbHelper.insertProduct(newProduct);
                          ((value) => newProduct.referenceId = value.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${newProduct.name} ถูกเพิ่มเรียบร้อยแล้ว'),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

