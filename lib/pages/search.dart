import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_project/database/database_helper.dart';
import 'package:app_project/database/model.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key, required this.dbHelper}) : super(key: key);
  final DatabaseHelper dbHelper;

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String _searchValue = '';
  List<Product> resultProducts = [];
  bool found = false;

  void _showResponse(QuerySnapshot response) {
    setState(() {
      if (response.docs.isNotEmpty) {
        found = true;
        resultProducts.clear();
        for (var element in response.docs) {
          resultProducts.add(Product(
              name: element.get('name'),
              description: element.get('description'),
              telphone: element.get('telphone'),
              datetime: element.get('datetime'),
              time: element.get('time'),
              pay: element.get('pay'),));
        }
      } else {
        found = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextField(
              onChanged: (value) => _searchValue = value,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.black),
                    onPressed: () async {
                      await widget.dbHelper
                          .searchProduct(_searchValue)
                          .then((res) {
                        _showResponse(res);
                      });
                    },
                  ),
                  hintText: 'Search',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/BG5.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        child: found
            ? buildFoundList()
            : const Center(
                child: Text("ไม่พบข้อมูล",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
      ),
    );
  }

  Widget buildFoundList() {
    return ListView.builder(
        itemCount: resultProducts.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            title: Text('ชื่อ: ${resultProducts[index].name}'),
            subtitle: Text('วันที่: ${resultProducts[index].datetime} เวลา:${resultProducts[index].time}น.'),
            trailing: Text('เบอร์โทรศัพท์: ${resultProducts[index].telphone}'),
          ));
        });
  }
}
