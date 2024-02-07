import 'package:flutter/material.dart';
import 'package:flutter_back_golang/pages/chat_page.dart';
import 'package:flutter_back_golang/pages/signup_page.dart';
import 'package:flutter_back_golang/widgets/app_button.dart';
import 'package:flutter_back_golang/widgets/app_logo.dart';
import 'package:flutter_back_golang/widgets/app_text_form_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailControler = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
              const SizedBox(height: 20),
              const Text(
                'おかえりなさい',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextFormField(
                      controller: _emailControler,
                      labelText: 'メールアドレス',
                      //空欄の場合にエラーを表示する
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'メールアドレスの入力が必須です';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    AppTextFormField(
                      controller: _passwordController,
                      labelText: 'パスワード',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'パスワードの入力が必須です';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              AppButton(
                height: 48,
                isLoading: _isLoading,
                onPressed: () async {
                  //バリデーションエラーがある場合は処理を中断する
                  if (!_formKey.currentState!.validate()) return;
                  final result = await _login(context,
                      email: _emailControler.text,
                      password: _passwordController.text);
                  if (result != null || !mounted) return;
                  // チャットページに遷移する
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ChatPage()));
                },
                text: '続ける',
              ),
              const SizedBox(height: 25),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text("アカウントをお持ちではありませんか?"),
                const SizedBox(width: 2),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignupPage()));
                  },
                  child: const Text('サインアップ'),
                ),
              ])
            ],
          ),
        ),
      )),
    );
  }

  Future<dynamic> _login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    //ログイン処理
    setState(() {
      _isLoading = true;
    });
    try {
      return await Supabase.instance.client.auth
          .signInWithPassword(password: password, email: email);
    } catch (e) {
      //エラー時の処理
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
