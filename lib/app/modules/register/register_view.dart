import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont;
import 'package:riverpod_example/app/modules/home/home_view.dart';
import '../../core/text_theme.dart';
import '../../providers/auth/register_provider.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(registerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: Ei.sym(h: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LzImage(
                'logo.png',
                size: 150,
              ),
              Textr(
                'Register',
                margin: Ei.only(b: 20),
                style: Gfont.fs(20).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: Ei.only(b: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: LzForm.input(
                  label: 'Fisrt name',
                  hint: 'Type your username',
                ),
              ),
              Container(
                margin: Ei.only(b: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: LzForm.input(
                  label: 'Last name',
                  hint: 'Type your username',
                ),
              ),
              Container(
                margin: Ei.only(b: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: LzForm.input(
                  label: 'Email',
                  hint: 'Your email address',
                ),
              ),
              Container(
                margin: Ei.only(b: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: LzForm.input(
                  label: 'Password',
                  hint: 'Type your password',
                  obsecureToggle: true,
                ),
              ),
              SizedBox(height: 20),
              LzButton(
                text: 'Continue',
                onTap: (state) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeView(),
                    ),
                  );
                },
                type: ButtonType.primary,
                gradient: true,
                color: null,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 120),
                radius: 25.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
