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

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailFocus.dispose();
    passFocus.dispose();
    btnFocus.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _login() {
    final email = emailController.text;
    final password = passController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    // Navega para a HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  controller: emailController,
                ),
                const SizedBox(height: 24),
                TvInput(
                  label: "Senha",
                  obscure: true,
                  focusNode: passFocus,
                  controller: passController,
                ),
                const SizedBox(height: 40),
                TvButton(
                  title: "Entrar",
                  focusNode: btnFocus,
                  onPressed: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
