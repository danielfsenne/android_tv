import 'package:flutter/material.dart';
import '../../home/home_page.dart';
import '../../core/widgets/tv_input.dart';
import '../../core/widgets/tv_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailFocus = FocusNode();
  final passFocus = FocusNode();
  final btnFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FocusTraversalGroup(
        child: Center(
          child: SizedBox(
            width: 550,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TvInput(
                  label: "Email",
                  focusNode: emailFocus,
                ),
                const SizedBox(height: 24),
                TvInput(
                  label: "Senha",
                  obscure: true,
                  focusNode: passFocus,
                ),
                const SizedBox(height: 40),
                TvButton(
                  title: "Entrar",
                  focusNode: btnFocus,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
