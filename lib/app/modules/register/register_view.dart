import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lazyui/lazyui.dart' hide Gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/modules/login/login_view.dart';

import '../../providers/auth/register_provider.dart';
import '../home/home_view.dart';

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
            children: [
              LzImage(
                'logo.png',
                size: 150,
                fit: BoxFit.cover,
              ),
              Textr(
                'Register',
                margin: Ei.only(b: 20),
                style: Gfont.fs(20).copyWith(fontWeight: FontWeight.bold, color: ColorConstants.primaryColor),
              ),
              LzFormGroup(
                keepLabel: true,
                sublabelStyle: SublabelStyle.text,
                children: [
                  LzForm.input(
                    label: 'First name',
                    hint: 'Type your username',
                  ),
                  LzForm.input(
                    label: 'Last name',
                    hint: 'Type your username',
                  ),
                  LzForm.input(
                    label: 'Email',
                    hint: 'Your email address',
                  ),
                  LzForm.input(
                    label: 'Password',
                    hint: 'Type your password',
                    obsecureToggle: true,
                  ),
                ],
              ),
              SizedBox(height: 20),
              LzButton(
                text: 'Continue',
                onTap: (state) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
                },
                type: ButtonType.primary,
                gradient: true,
                color: null,
                padding: Ei.sym(v: 10, h: 130),
                radius: 25.0,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
