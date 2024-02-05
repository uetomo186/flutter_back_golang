import 'package:flutter/material.dart';
import 'package:flutter_back_golang/widgets/app_button.dart';
import 'package:flutter_back_golang/widgets/app_logo.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(16),
        height: 300,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const AppLogo(),
          const Text('ようこそ！スーパーチャットへ'),
          const Text('ログインして始めよう！'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(width: 80, onPressed: () {}, text: 'ログイン'),
              AppButton(width: 80, onPressed: () {}, text: '新規登録')
            ],
          )
        ]),
      )),
    );
  }
}
