import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/users/auth_local.dart';
import 'package:sante_pour_tous/src/routes/routes.dart';

import '../../app_state/app_state.dart';
import '../../widgets/btn_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool isloading = false;

  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: Responsive.isDesktop(context)
            ? const EdgeInsets.all(50.0)
            : const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.deepPurpleAccent,
          child: Row(
            children: [
              if (!Responsive.isMobile(context))
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset('assets/images/stethoscope.png',
                            fit: BoxFit.cover,
                            height: Responsive.isDesktop(context)
                                ? height / 1.5
                                : height / 3),
                      ),
                    ],
                  ),
                ),
              Expanded(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.topRight, child: helpWidget()),
                        logoWidget(),
                        // titleText(),
                        const SizedBox(height: 20),
                        userNameBuild(),
                        const SizedBox(height: 20),
                        passwordBuild(),
                        const SizedBox(height: 20),
                        loginButtonBuild(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [forgotPasswordWidget(), registeridget()],
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget logoWidget() {
    var height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Column(
      children: [
        Image.asset(
          "assets/images/stethoscope.png",
          height: Responsive.isDesktop(context) ? height / 10 : height / 10,
          width: size.width,
        ),
        const SizedBox(height: p20),
        Text('SANTé POUR TOUS'.toUpperCase(), style: bodyLarge)
      ],
    );
  }

  Widget userNameBuild() {
    return Padding(
        padding: const EdgeInsets.all(p20),
        child: TextFormField(
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Matricule',
          ),
          controller: matriculeController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ce champ est obligatoire';
            }
            return null;
          },
          style: const TextStyle(),
        ));
  }

  Widget passwordBuild() {
    return Padding(
        padding: const EdgeInsets.all(p20),
        child: TextFormField(
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Mot de passe',
          ),
          controller: passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ce champ est obligatoire';
            }
            return null;
          },
          style: const TextStyle(),
        ));
  }

  Widget loginButtonBuild() {
    return Padding(
      padding: const EdgeInsets.all(p20),
      child: BtnWidget(
          title: 'Login',
          isLoading: isloading,
          press: () async {
            print("matriculeController ${matriculeController.text}");
            print("passwordController ${passwordController.text}");

            final form = _form.currentState!;
            if (form.validate()) {
              AuthLocal()
                  .login(matriculeController.text, passwordController.text)
                  .then((value) {
                    // form.reset();
                if (value) {
                  // Routemaster.of(context).push(HomeRoutes.home);
                Provider.of<AppState>(context, listen: false).isLoggedIn =true;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Vous êtes connecté avec succès!"),
                    backgroundColor: Colors.green[700],
                  ));
                } else {
                  Routemaster.of(context).push(UserRoutes.login);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Erreur, verifier vos acces!"),
                    backgroundColor: Colors.red[700],
                  ));
                }
              });
              
            }
          }),
    );
  }

  Widget forgotPasswordWidget() {
    final button = Theme.of(context).textTheme.button;
    return TextButton(
        onPressed: () {},
        child: Text(
          'Mot de passe oublié ?',
          style: button,
          textAlign: TextAlign.start,
        ));
  }

  Widget helpWidget() {
    final button = Theme.of(context).textTheme.button;
    return TextButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.help,
          color: Colors.teal,
        ),
        label: Text(
          'Besoin d\'aide?',
          style: button,
        ));
  }

  Widget registeridget() {
    final button = Theme.of(context).textTheme.button;
    return TextButton.icon(
        onPressed: () {
          Routemaster.of(context).push(UserRoutes.register);
        },
        icon: const Icon(
          Icons.person_add,
          color: Colors.teal,
        ),
        label: Text(
          'Inscription',
          style: button,
        ));
  }
}
