import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_project/database/database_helper.dart';
import 'package:app_project/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:app_project/database/model.dart';
import 'package:quickalert/quickalert.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.dbHelper}) : super(key: key);

  DatabaseHelper dbHelper;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = [];

  Future<dynamic> _showConfirmDialog(BuildContext context, String action) {
    return QuickAlert.show(
      context: context,
      barrierDismissible: true,
      type: QuickAlertType.confirm,
      text: 'Are you sure?',
      cancelBtnText: 'No',
      confirmBtnText: 'Yes',
      onCancelBtnTap: () {
        Navigator.of(context).pop(false);
      },
      onConfirmBtnTap: () {
        Navigator.of(context).pop(true);
      },
      confirmBtnColor: Colors.white,
      backgroundColor: Colors.black,
      confirmBtnTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      cancelBtnTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      barrierColor: Color.fromARGB(255, 109, 108, 108), //สีพื้นหลัง
      titleColor: Colors.white, //สีข้อความ
      textColor: Colors.white, //สีข้อความ
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.search_outlined), //ไอคอน
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchProduct(dbHelper: widget.dbHelper);
          }));
        },
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
        child: StreamBuilder<QuerySnapshot>(
            stream: widget.dbHelper.getStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              products.clear();
              for (var element in snapshot.data!.docs) {
                products.add(Product(
                    name: element.get('name'),
                    description: element.get('description'),
                    telphone: element.get('telphone'),
                    datetime: element.get('datetime'),
                    time: element.get('time'),
                    pay: element.get('pay'),
                    referenceId: element.id));
              }
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.blue),
                    secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete_forever_outlined,
                            color: Colors.white, size: 30)),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        widget.dbHelper.deleteProduct(products[index]);
                      }
                    },
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        return await _showConfirmDialog(context, 'delete');
                      }
                      return false;
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(products[index].name),
                        subtitle: Text(
                            '${products[index].description.toString()} '),
                        trailing: products[index].pay == 1
                            ? const Icon(Icons.attach_money,
                                color: Colors.green, size: 30,)
                            : null,
                        onTap: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(productdetail: products[index]),
                            ),
                          );
                          if (result != null) {
                            products[index].pay = result;
                            widget.dbHelper.updateProduct(products[index]);
                          }
                        },
                        onLongPress: () async {
                          await ModalEditProductForm(
                            dbHelper: widget.dbHelper,
                            editedProduct: products[index],
                          ).showModalInputForm(context);
                        },
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.productdetail}) : super(key: key);

  final Product productdetail;

  @override
  Widget build(BuildContext context) {
    var result = productdetail.pay;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productdetail.name,
          style: const TextStyle(fontSize: 22),
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20),
              color: Colors.white70,
              child: Text(
                productdetail.description,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20),
              color: Colors.white70,
              child: Text(
                'วันที่ : ${productdetail.datetime.toString()} ',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20),
              color: Colors.white70,
              child: Text(
                'เวลา : ${productdetail.time.toString()} น.',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20),
              color: Colors.white70,
              child: Text(
                'เบอร์โทรศัพท์ : ${productdetail.telphone.toString()}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 40),
                        backgroundColor: productdetail.pay == 1
                            ? Colors.red
                            : Colors.green),
                    child: productdetail.pay == 1
                        ? const Text('ยังไม่จ่าย')
                        : const Text('จ่าย'),
                    onPressed: () {
                      result = productdetail.pay == 1 ? 0 : 1;
                      Navigator.pop(context, result);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('กลับ'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 40),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalEditProductForm {
  ModalEditProductForm(
      {Key? key, required this.dbHelper, required this.editedProduct});

  DatabaseHelper dbHelper;
  Product editedProduct;

  String _name = '',
      _description = '',
      _datetime = '',
      _telphone = '',
      _time = '';
  int _pay = 0;
  String? _referenceId;

  Future<dynamic> showModalInputForm(BuildContext context) {
    _name = editedProduct.name;
    _description = editedProduct.description;
    _telphone = editedProduct.telphone;
    _datetime = editedProduct.datetime;
    _time = editedProduct.time;
    _pay = editedProduct.pay;
    _referenceId = editedProduct.referenceId;

    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Center(
                    child: Text(
                      'แก้ไขข้อมูล',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: editedProduct.name,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: ' ชื่อ-นามสกุล',
                          hintText: ' กรุณากรอกชื่อ-นามสกุล...',
                        ),
                        onChanged: (value) {
                          _name = value;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: editedProduct.description,
                        decoration: const InputDecoration(
                          labelText: ' สนามกีฬาที่ ',
                          hintText: ' กรุณากรอกสนามกีฬาที่...',
                        ),
                        onChanged: (value) {
                          _description = value;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: editedProduct.datetime,
                        decoration: const InputDecoration(
                          labelText: ' วันที่',
                          hintText: ' กรุณากรอกวันที่...',
                        ),
                        onChanged: (value) {
                          _datetime = value;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: editedProduct.time.toString(),
                        decoration: const InputDecoration(
                          labelText: ' เวลา',
                          hintText: ' กรุณากรอกเวลา...',
                        ),
                        onChanged: (value) {
                          _time = value;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: editedProduct.telphone,
                        decoration: const InputDecoration(
                          labelText: ' เบอร์โทรศัพท์',
                          hintText: ' กรุณากรอกเบอร์โทรศัพท์...',
                        ),
                        onChanged: (value) {
                          _telphone = value;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(
                          child: const Text('Update'),
                          onPressed: () async {
                            var newProduct = Product(
                                name: _name,
                                description: _description,
                                telphone: _telphone,
                                datetime: _datetime,
                                time: _time,
                                pay: _pay,
                                referenceId: _referenceId);
                            await dbHelper.updateProduct(newProduct);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${newProduct.name} แก้ไขข้อมูลเรียบร้อยแล้ว'),
                              ),
                            );
                            Navigator.pop(context, newProduct);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
