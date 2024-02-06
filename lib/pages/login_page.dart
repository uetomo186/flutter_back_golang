import 'package:flutter/material.dart';
import 'package:flutter_back_golang/widgets/app_button.dart';
import 'package:flutter_back_golang/widgets/app_logo.dart';
import 'package:flutter_back_golang/widgets/message_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppLogo(),
              const SizedBox(height: 25),
              const Text(
                'おかえりなさい',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              const Form(
                child: Column(
                  children: [
                    AppTextFormField(
                      labelText: 'メールアドレス',
                    ),
                    AppTextFormField(
                      labelText: 'パスワード',
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              AppButton(
                height: 48,
                onPressed: () {},
                text: '続ける',
              ),
              const SizedBox(height: 25),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text("アカウントをお持ちではありませんか?"),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  child: const Text('サインアップ'),
                ),
              ])
            ],
          ),
        ),
      )),
    );
  }
}
