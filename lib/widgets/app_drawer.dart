import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        const Spacer(),
        ListTile(
          title: TextButton(
            onPressed: () async {
              //ログアウトの処理
              final result = await _logout(context);
            },
            child: const Text('ログアウト',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                )),
          ),
        ),
      ]),
    );
  }

  Future<bool> _logout(BuildContext context) async {
    // ログアウトの処理
    try {
      await Supabase.instance.client.auth.signOut();
      return true;
    } catch (e) {
      //スナックバーを表示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
    return false;
  }
}
