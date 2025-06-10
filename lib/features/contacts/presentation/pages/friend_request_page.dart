import 'package:flutter/cupertino.dart';

class FriendRequestPage extends StatefulWidget {
  const FriendRequestPage({super.key});

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}

class _FriendRequestPageState extends State<FriendRequestPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'friend_request',
        middle: Text('好友请求'),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(
        child: Center(
          child: Text('好友请求页面 - 待实现'),
        ),
      ),
    );
  }
}
