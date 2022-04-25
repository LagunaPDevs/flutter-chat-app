import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/user.dart';
import 'package:realtime_chat/pages/users_page/widgets/users_tile_list.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final users = [
    User(uid: '1', name: 'Maria', email: 'test1@test.com', online: true),
    User(uid: '2', name: 'Javier', email: 'test2@test.com', online: false),
    User(uid: '3', name: 'Bob', email: 'test3@test.com', online: true),
    User(uid: '4', name: 'Lola', email: 'test4@test.com', online: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My name', style: TextStyle(color: Colors.black54)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.exit_to_app, color: Colors.black54)),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.check_circle, color: Colors.blue))
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _refreshUsers,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue.shade400),
            waterDropColor: Colors.blue.shade400,
          ),
          child: _usersListView(),
        ));
  }

  ListView _usersListView() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => UsersTileList(user: users[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: users.length);
  }

  void _refreshUsers() async {
    await Future.delayed(Duration(microseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
