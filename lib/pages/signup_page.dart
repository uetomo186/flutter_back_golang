import 'package:flutter/material.dart';
import 'package:flutter_back_golang/pages/login_page.dart';
import 'package:flutter_back_golang/widgets/app_button.dart';
import 'package:flutter_back_golang/widgets/app_logo.dart';
import 'package:flutter_back_golang/widgets/message_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailControler = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        controller: _emailControler,
                        labelText: 'メールアドレス',
                        // 空欄の場合にエラーを表示する
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'メールアドレスを入力してください';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      AppTextFormField(
                        controller: _passwordController,
                        labelText: 'パスワード',
                        // 空欄の場合にエラーを表示する
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'パスワードを入力してください';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      AppTextFormField(
                        controller: _confirmPasswordController,
                        labelText: 'もう一度パスワードを入力',
                        obscureText: true,
                        // パスワードが一致しない場合エラーを表示する
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'パスワードが一致しません';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(
                    height: 48,
                    onPressed: () async {
                      // バリデーションエラーがある場合、処理を中断する
                      if (!_formKey.currentState!.validate()) return;
                    },
                    text: '続ける'),
                const SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('すでにアカウントをお持ちですか？'),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
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

  Future<dynamic> _signup({
    required String email,
    required String password,
  }) async {
    // ここにサインアップ処理を実装
    return await Supabase.instance.client.auth
        .signUp(email: email, password: password);
  }
}
