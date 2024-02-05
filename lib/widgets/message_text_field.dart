import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    this.labelText = '',
    this.obscureText = false,
    this.validator,
  });
  // 入力値を管理するコントローラー
  final TextEditingController? controller;
  // 入力欄のラベル
  final String labelText;
  //入力値の値をマスクキングするのか
  final bool obscureText;
  //入力値のバリデーション処理
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      obscureText: obscureText,
      cursorColor: Colors.green,
      validator: validator,
    );
  }
}
