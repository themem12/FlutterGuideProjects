import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/providers/login_form_provider.dart';
import 'package:form_validation/ui/input_decoration.dart';
import 'package:form_validation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: ((context) => LoginFormProvider()),
                    child: const _LoginForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Crear una nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => loginForm.email = value,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputsDecorations.authInputDecoration(
                  hintText: 'john@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_outlined),
              validator: (value) {
                String patter = "^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}";
                RegExp regExp = RegExp(patter);
                return regExp.hasMatch(value ?? '') ? null : 'Correo inválido.';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              onChanged: (value) => loginForm.password = value,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputsDecorations.authInputDecoration(
                  hintText: '********',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                } else {
                  return 'Contraseña inválida (mínimo 6 caractéres).';
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;

                      await Future.delayed(Duration(seconds: 2));

                      loginForm.isLoading = false;

                      Navigator.pushReplacementNamed(context, 'home');
                    },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: loginForm.isLoading
                    ? const CupertinoActivityIndicator()
                    : const Text(
                        'Ingresar',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
