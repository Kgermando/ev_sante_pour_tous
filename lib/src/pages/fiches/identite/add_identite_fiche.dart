import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/identite_local.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/helpers/user_preferences.dart';
import 'package:sante_pour_tous/src/helpers/user_secure_storage.dart';
import 'package:sante_pour_tous/src/models/fiches/identite_fiche_model.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/utils/province.dart';
import 'package:sante_pour_tous/src/widgets/btn_widget.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class AddIdentiteFiche extends StatefulWidget {
  const AddIdentiteFiche({Key? key}) : super(key: key);

  @override
  State<AddIdentiteFiche> createState() => _AddIdentiteFicheState();
}

class _AddIdentiteFicheState extends State<AddIdentiteFiche> {
  final ScrollController _controllerScroll = ScrollController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final provincesList = Province().provinces; 

  TextEditingController nameController = TextEditingController();
  TextEditingController postNomController = TextEditingController();
  TextEditingController preNomController = TextEditingController();
  String? sexe;
  TextEditingController ageController = TextEditingController();
  TextEditingController tailleController = TextEditingController();
  TextEditingController poidsController = TextEditingController();
  TextEditingController tensionArterielleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController nomPereController = TextEditingController();
  TextEditingController nomMereController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  String? province;
  String? institut;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    postNomController.dispose();
    preNomController.dispose();
    ageController.dispose();
    tailleController.dispose();
    poidsController.dispose();
    tensionArterielleController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    nomPereController.dispose();
    nomMereController.dispose();
    adresseController.dispose();
    super.dispose();
  }

  String? matricule;
  List<UniversiteModel> univList = [];

  Future<void> getData() async {
    final user = await UserSecureStorage().readUser();
    final dataUniv = await UniversiteLocal().getAllData();
    if (!mounted) return;
    setState(() {
      matricule = user.matricule;
      univList = dataUniv;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbar(title: 'New Fiche'),
          Expanded(child: addFicheWidget())
        ],
      ),
    ));
  }

  Widget addFicheWidget() {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(p8),
            child: SizedBox(
              width: Responsive.isDesktop(context)
                  ? MediaQuery.of(context).size.width / 1.5
                  : MediaQuery.of(context).size.width / 1.1,
              child: Card(
                elevation: 10,
                child: Scrollbar(
                  controller: _controllerScroll,
                  child: ListView(
                    controller: _controllerScroll,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [PrintWidget(onPressed: () {})],
                      ),
                      const SizedBox(
                        height: p20,
                      ),
                      univWidget(),
                      Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: nameWidget()),
                                const SizedBox(
                                  width: p10,
                                ),
                                Expanded(child: postNomWidget()),
                              ],
                            )
                          : Column(
                              children: [nameWidget(), postNomWidget()],
                            ),
                      Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: preNomWidget()),
                                const SizedBox(
                                  width: p10,
                                ),
                                Expanded(child: sexeWidget()),
                              ],
                            )
                          : Column(
                              children: [preNomWidget(), sexeWidget()],
                            ),
                      Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: ageWidget()),
                                const SizedBox(
                                  width: p10,
                                ),
                                Expanded(child: tailleWidget()),
                              ],
                            )
                          : Column(
                              children: [ageWidget(), tailleWidget()],
                            ),
                      Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: poidsWidget()),
                                const SizedBox(
                                  width: p10,
                                ),
                                Expanded(child: tensionArterielleWidget()),
                              ],
                            )
                          : Column(
                              children: [
                                poidsWidget(),
                                tensionArterielleWidget()
                              ],
                            ),
                      Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: emailWidget()),
                                const SizedBox(
                                  width: p10,
                                ),
                                Expanded(child: telephoneWidget()),
                              ],
                            )
                          : Column(
                              children: [emailWidget(), telephoneWidget()],
                            ),
                      Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: nomPereWidget()),
                                const SizedBox(
                                  width: p10,
                                ),
                                Expanded(child: nomMereWidget()),
                              ],
                            )
                          : Column(
                              children: [nomPereWidget(), nomMereWidget()],
                            ),
                      Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: provinceOrigineWidget()),
                                const SizedBox(
                                  width: p10,
                                ),
                                Expanded(child: adresseWidget()),
                              ],
                            )
                          : Column(
                              children: [
                                provinceOrigineWidget(),
                                adresseWidget()
                              ],
                            ),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget univWidget() {
    final univ = univList.map((e) => e.name).toSet().toList();
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Select établissement',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: institut,
        isExpanded: true,
        items: univ.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            institut = value!;
          });
        },
      ),
    );
  }

  Widget nameWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: nameController,
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

  Widget postNomWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: postNomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Post-Nom',
            hintText: 'Post Nom',
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

  Widget preNomWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: preNomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Prénom',
            hintText: 'Prénom',
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

  Widget sexeWidget() {
    final List<String> dropdownList = ["Femme", "Homme", "Autres"];
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Sexe',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: sexe,
        isExpanded: true,
        items: dropdownList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            sexe = value!;
          });
        },
      ),
    );
  }

  Widget ageWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: ageController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Age',
            hintText: 'age',
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

  Widget tailleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: tailleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Taille',
            hintText: 'taille',
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

  Widget poidsWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: poidsController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Poids',
            hintText: 'poids',
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

  Widget tensionArterielleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: tensionArterielleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Tension arterielle',
            hintText: 'Tension arterielle',
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

  Widget emailWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Email',
            hintText: 'email',
          ),
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(),
          // validator: (value) {
          //   if (value != null && value.isEmpty) {
          //     return 'Ce champs est obligatoire';
          //   } else {
          //     return null;
          //   }
          // },
        ));
  }

  Widget telephoneWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: telephoneController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Téléphone',
            hintText: 'telephone',
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

  Widget nomPereWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: TextFormField(
        controller: nomPereController,
        decoration: InputDecoration(
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Nom père',
          hintText: 'Nom père',
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

  Widget nomMereWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: nomMereController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom de la mère',
            hintText: 'Nom de la mère',
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

  Widget provinceOrigineWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Province d\'origine',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: province,
        isExpanded: true,
        items: provincesList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            province = value!;
          });
        },
      ),
    );
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
            hintText: 'Adresse',
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
    final identiteFicheModel = IdentiteFicheModel(
        nom: nameController.text,
        postNom: postNomController.text,
        preNom: preNomController.text,
        sexe: sexe.toString(),
        age: ageController.text,
        taille: tailleController.text,
        poids: poidsController.text,
        tensionArterielle: tensionArterielleController.text,
        email: emailController.text,
        telephone: telephoneController.text,
        nomPere: nomPereController.text,
        nomMere: nomMereController.text,
        provinceOrigine: province.toString(),
        adresse: adresseController.text,
        statut: 'En attente',
        signature: matricule.toString(),
        institut: institut.toString(),
        created: DateTime.now());

    await IdentiteLocal().insertData(identiteFicheModel);
    Routemaster.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Enregistrer avec succès!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
