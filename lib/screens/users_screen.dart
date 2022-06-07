import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp12_api_app/api/controllers/auth_api_controller.dart';
import 'package:vp12_api_app/api/controllers/user_api_controller.dart';
import 'package:vp12_api_app/models/api_response.dart';
import 'package:vp12_api_app/models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late Future<List<User>> _future;
  List<User> _users = <User>[];

  @override
  void initState() {
    super.initState();
    // _future = UserApiController().readUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Users',
            style: GoogleFonts.cairo(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                ApiResponse apiResponse = await AuthApiController().logout();
                if (apiResponse.status) {
                  Navigator.pushReplacementNamed(context, '/login_screen');
                }
              },
              icon: Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/images_screen');
              },
              icon: Icon(Icons.image),
            ),
          ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List<User>>(
          future: UserApiController().readUsers(),
          // future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              _users = snapshot.data!;
              return ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        _users[index].image,
                      ),
                    ),
                    title: Text(_users[index].firstName),
                    subtitle: Text(_users[index].email),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.warning,
                      size: 80,
                      color: Colors.black45,
                    ),
                    Text(
                      "NO DATA",
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
