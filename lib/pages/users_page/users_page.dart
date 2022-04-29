import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/user.dart';
import 'package:realtime_chat/pages/users_page/widgets/users_tile_list.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/socket_service.dart';
import 'package:realtime_chat/services/users_service.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usersSevice = UsersService();
  List<User> users = [];

  @override
  void initState() {
    _refreshUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(user.name, style: TextStyle(color: Colors.black54)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                // Disconnect of socket service
                socketService.disconnect();

                Navigator.pushReplacementNamed(context, 'login');
                authService.logout();
              },
              icon: Icon(Icons.exit_to_app, color: Colors.black54)),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: (socketService.serverStatus == ServerStatus.Online)
                    ? Icon(Icons.check_circle, color: Colors.blue.shade400)
                    : Icon(Icons.offline_bolt, color: Colors.red))
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
    users = await usersSevice.getUsers();
    setState(() {});
    //await Future.delayed(Duration(microseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
