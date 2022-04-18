import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/utils/country.dart';
import 'package:sante_pour_tous/src/utils/province.dart';
import 'package:sante_pour_tous/src/widgets/btn_widget.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';
import 'package:sante_pour_tous/src/widgets/title_widget.dart';

class AddUniversite extends StatefulWidget {
  const AddUniversite({Key? key}) : super(key: key);

  @override
  State<AddUniversite> createState() => _AddUniversiteState();
}

class _AddUniversiteState extends State<AddUniversite> {
  final ScrollController _controllerScroll = ScrollController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final world = Country().world;
  final provincesList = Province().provinces;

  TextEditingController nameController = TextEditingController();
  TextEditingController sousNomController = TextEditingController();
  TextEditingController boitePostaleController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController sitewebController = TextEditingController();
  String? pays;
  String? province;

  @override
  void dispose() {
    nameController.dispose();
    sousNomController.dispose();
    adresseController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    sitewebController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbar(title: 'New univ'),
          Expanded(
            child: addAgentWidget()
          )
        ],
      )
    );
  }

  Widget addAgentWidget() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(p16),
                  child: SizedBox(
                    width: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    child: Scrollbar(
                      controller: _controllerScroll,
                      child: ListView(
                        controller: _controllerScroll,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TitleWidget(title: 'Ajout établissement'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [PrintWidget(onPressed: () {})],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: p20,
                          ),
                          Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: nameWidget()),
                                const SizedBox(
                                  height: p20,
                                ),
                                Expanded(child: sousNomWidget()),
                              ],
                            )
                          : Column(
                              children: [
                                nameWidget(),
                                sousNomWidget()
                              ],
                            ),
                          Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: boitePostaleWidget()),
                                const SizedBox(
                                  height: p20,
                                ),
                                Expanded(child: paysWidget()),
                              ],
                            )
                          : Column(
                              children: [
                                boitePostaleWidget(),
                                paysWidget()
                              ],
                            ),
                          Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: provinceWidget()),
                                const SizedBox(
                                  height: p20,
                                ),
                                Expanded(child: adresseWidget()),
                              ],
                            )
                          : Column(
                              children: [
                                provinceWidget(),
                                adresseWidget()
                              ],
                            ),
                          Responsive.isDesktop(context)
                          ? Row(
                              children: [
                                Expanded(child: emailidget()),
                                const SizedBox(
                                  height: p20,
                                ),
                                Expanded(child: telephoneWidget()),
                              ],
                            )
                          : Column(
                              children: [
                                emailidget(),
                                telephoneWidget()
                              ],
                            ),
                          sitewebWidget(),
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
            ),
          ],
        ),
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

  Widget sousNomWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: sousNomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom complet',
            hintText: 'Nom complet',
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

  Widget boitePostaleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: boitePostaleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Boîte postale',
            hintText: 'Boîte postale',
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

  Widget paysWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Pays',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: pays,
        isExpanded: true,
        items: world.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            pays = value!;
          });
        },
      ),
    );
  }

  Widget provinceWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Province',
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
            labelText: 'adresse',
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

  Widget emailidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Email',
            hintText: 'Email',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
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
            hintText: 'Téléphone',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
        ));
  }

  Widget sitewebWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: sitewebController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Site web',
            hintText: 'Site web',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
        ));
  }

  Future<void> submit() async {
    final universiteModel = UniversiteModel(
        name: nameController.text,
        sousNom: sousNomController.text,
        boitePostale: boitePostaleController.text,
        pays: pays.toString(),
        province: province.toString(),
        adresse: adresseController.text,
        email: emailController.text,
        telephone: telephoneController.text,
        siteweb: sitewebController.text,
        created: DateTime.now());
    await UniversiteLocal().insertData(universiteModel);
    Routemaster.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Enregistrer avec succès!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
