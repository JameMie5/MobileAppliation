import 'package:app_project/home.dart';
import 'package:flutter/material.dart';

class UserInboxPage extends StatelessWidget {
  const UserInboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/BG4.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/logo.jpg'),
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Text(
                    ' นายธนพล กันหา \nนายธีรเทพ น้ำใจดี',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                title: const Text(
                  'thanaphol.kan@ku.th \n thiratep.n@ku.th',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Email Address'),
                      content: const Text(
                          'thanaphol.kan@ku.th\nthanaphol.kan@ku.th\n-\n-'),
                      actions: [
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(
                height: 20,
              ),
              ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                title: const Text(
                  '123-456-7890',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Telephone Address'),
                      content: const Text(
                          'โทรศัพท์ : 092-3125-9784\nโทรศัพท์ : 123-456-7890\nโทรศัพท์บ้าน : 02-356-5649'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(
                height: 20,
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: const Text('Address',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('About Me'),
                      content: const Text(
                          'บ้านเลขที่ 123/45 หมู่ 1 ตำบล บางขุนเทียน อำเภอ บางขุนเทียน \nจังหวัด นนทบุรี 11110'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: const Text('Log Out'),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
