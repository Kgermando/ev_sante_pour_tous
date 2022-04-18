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

class UpdateUniversite extends StatefulWidget {
  const UpdateUniversite({Key? key, required this.universiteModel})
      : super(key: key);
  final UniversiteModel universiteModel;

  @override
  State<UpdateUniversite> createState() => _UpdateUniversiteState();
}

class _UpdateUniversiteState extends State<UpdateUniversite> {
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

  int? id;
  String? pays;
  String? province;

  @override
  void initState() {
    id = widget.universiteModel.id;
    nameController = TextEditingController(text: widget.universiteModel.name);
    sousNomController =
        TextEditingController(text: widget.universiteModel.name);
    boitePostaleController =
        TextEditingController(text: widget.universiteModel.boitePostale);
    adresseController =
        TextEditingController(text: widget.universiteModel.name);
    emailController = TextEditingController(text: widget.universiteModel.name);
    telephoneController =
        TextEditingController(text: widget.universiteModel.name);
    sitewebController =
        TextEditingController(text: widget.universiteModel.name);
    pays = widget.universiteModel.pays;
    province = widget.universiteModel.province;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    sousNomController.dispose();
    boitePostaleController.dispose();
    adresseController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    sitewebController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(p16),
            width: (Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(p10),
              border: Border.all(
                color: Colors.blueGrey.shade700,
                width: 2.0,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 10,
                child: ListView(
                  controller: _controllerScroll,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomAppbar(title: widget.universiteModel.name),
                        Column(
                          children: [
                            Row(
                              children: [
                                PrintWidget(
                                    tooltip: 'Imprimer le document',
                                    onPressed: () {})
                              ],
                            ),
                            nameWidget(),
                            sousNomWidget(),
                            paysWidget(),
                            provinceWidget(),
                            adresseWidget(),
                            emailidget(),
                            telephoneWidget(),
                            sitewebWidget(),
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
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
        ));
  }

  Widget sousNomWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
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
      margin: const EdgeInsets.only(bottom: p10, left: p5),
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
      margin: const EdgeInsets.only(bottom: p10, left: p5),
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
        margin: const EdgeInsets.only(bottom: p10, left: p5),
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
        ));
  }

  Widget emailidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
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
        margin: const EdgeInsets.only(bottom: p10, left: p5),
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
        margin: const EdgeInsets.only(bottom: p10, left: p5),
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
      id: widget.universiteModel.id,
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
    await UniversiteLocal().updateData(universiteModel);
    Routemaster.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Mise à jour réussie!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
