import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import 'package:qrcode_bloc/routes/router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailC =
      TextEditingController(text: "admin@gmail.com");
  final TextEditingController passC = TextEditingController(text: "admin123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: emailC,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            const SizedBox(height: 20),
            TextField(
                autocorrect: false,
                controller: passC,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9)))),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(AuthEventLogin(emailC.text, passC.text));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
              ),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthStateLogin) {
                    context.goNamed(Routes.home);
                  }
                  if (state is AuthStateError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            duration: Duration(seconds: 2),));
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthStateLoading) {
                        return const Text("LOADING");
                      }
                      return const Text("LOGIN");
                    },
                  );
                },
              ),
            )
          ],
        ));
  }
}
