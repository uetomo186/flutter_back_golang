import 'package:flutter/material.dart';
import 'package:flutter_back_golang/pages/login_page.dart';
import 'package:flutter_back_golang/pages/signup_page.dart';
import 'package:flutter_back_golang/widgets/app_button.dart';
import 'package:flutter_back_golang/widgets/app_logo.dart';
import 'package:gap/gap.dart';

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
          const Gap(24),
          const Text('ようこそ！スーパーチャットへ'),
          const Gap(16),
          const Text('ログインして始めよう！'),
          const Gap(24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                  width: 120,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  text: 'ログイン'),
              const SizedBox(width: 24),
              AppButton(
                  width: 120,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupPage(),
                      ),
                    );
                  },
                  text: '新規登録')
            ],
          )
        ]),
      )),
    );
  }
}
