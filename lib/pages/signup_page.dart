import 'package:flutter/material.dart';
import 'package:flutter_back_golang/widgets/app_button.dart';
import 'package:flutter_back_golang/widgets/app_logo.dart';
import 'package:flutter_back_golang/widgets/message_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'アカウントを作成する',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const Form(
                  child: Column(
                    children: [
                      AppTextFormField(labelText: 'メールアドレス'),
                      SizedBox(height: 24),
                      AppTextFormField(
                        labelText: 'パスワード',
                        obscureText: true,
                      ),
                      SizedBox(height: 24),
                      AppTextFormField(
                        labelText: 'もう一度パスワードを入力',
                        obscureText: true,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(height: 48, onPressed: () async {}, text: '続ける'),
                const SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('すでにアカウントをお持ちですか？'),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('ログイン'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
