import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/users/users_local.dart';
import 'package:sante_pour_tous/src/models/users/user_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/widgets/btn_widget.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController matriculeController = TextEditingController();
  String? role;
  bool isOnline = false;
  TextEditingController passwordHashController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  DateTime? createdAt;
  int? id;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    matriculeController.dispose();
    passwordHashController.dispose();
    adresseController.dispose();

    super.dispose();
  }

  Future getData() async {
    var data = await UserLocal().getOneData(widget.id!);
    if (!mounted) return;
    setState(() {
      nomController = TextEditingController(text: data.nom);
      prenomController = TextEditingController(text: data.prenom);
      matriculeController = TextEditingController(text: data.matricule);
      role = data.role;
      isOnline = data.isOnline;
      passwordHashController = TextEditingController(text: data.passwordHash);
      adresseController = TextEditingController(text: data.adresse);
      createdAt = data.createdAt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbar(title: 'Profile'),
          Expanded(child: formsWidget())
        ],
      ));
  }

  Widget formsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(p16),
            width: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width / 1.1,
            child: Card(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [PrintWidget(onPressed: () {})],
                  ),
                  nameWidget(),
                  prenomWidget(),
                  matriculeWidget(),
                  accreditationWidget(),
                  passwordHashWidget(),
                  adresseWidget(),
                  const SizedBox(
                    height: p20,
                  ),
                  BtnWidget(
                      title: 'Soumettre',
                      press: () {
                        setState(() {
                          isLoading = true;
                        });
                        final form = _formKey.currentState!;
                        if (form.validate()) {
                          submit();
                          form.reset();
                        }
                      },
                      isLoading: isLoading)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget nameWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: nomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom',
            hintText: 'Nom',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget prenomWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: prenomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Prenom',
            hintText: 'prenom',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget matriculeWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: matriculeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Matricule',
            hintText: 'matricule',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget accreditationWidget() {
    final List<String> dropdownList = ["Admin", "Loboratin", "Medecin", "User"];
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Accreditation',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          value: role,
          isExpanded: true,
          items: dropdownList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              role = value!;
            });
          },
        ));
  }

  Widget passwordHashWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: passwordHashController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Mot de passe',
            hintText: 'passwordHash',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget adresseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: adresseController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse',
            hintText: 'adresse',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Future<void> submit() async {
    final userModel = UserModel(
        nom: nomController.text,
        prenom: prenomController.text,
        matricule: matriculeController.text,
        role: role.toString(),
        isOnline: isOnline,
        createdAt: createdAt!,
        passwordHash: passwordHashController.text,
        adresse: adresseController.text);

    await UserLocal().updateData(userModel);
    Routemaster.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Enregistrer avec succès!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
