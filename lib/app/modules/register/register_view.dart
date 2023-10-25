import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lazyui/lazyui.dart' hide Gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';

import '../../providers/auth/register_provider.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(RegisterProvider.notifier);

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
                    model: notifier.formm['first_name'],
                  ),
                  LzForm.input(
                    label: 'Last name',
                    hint: 'Type your username',
                    model: notifier.formm['last_name'],
                  ),
                  LzForm.input(
                    label: 'Email',
                    hint: 'Your email address',
                    model: notifier.formm['email'],
                  ),
                  LzForm.input(
                    label: 'Password',
                    hint: 'Type your password',
                    model: notifier.formm['password'],
                    obsecureToggle: true,
                  ),
                  LzForm.input(
                    label: 'Password Confirmation',
                    hint: 'Type your password',
                    model: notifier.formm['password_confirmation'],
                    obsecureToggle: true,
                  ),
                ],
              ),
              SizedBox(height: 20),
              LzButton(
                text: 'Register',
                onTap: (state) {
                  notifier.register(context);
                },
                type: ButtonType.primary,
                gradient: true,
                color: null,
                padding: Ei.sym(v: 10, h: 110),
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
