import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/conclusion_local.dart';
import 'package:sante_pour_tous/src/global/local/fiches/identite_local.dart';
import 'package:sante_pour_tous/src/helpers/user_preferences.dart';
import 'package:sante_pour_tous/src/helpers/user_secure_storage.dart';
import 'package:sante_pour_tous/src/models/fiches/conclusion_fiche_model.dart';
import 'package:sante_pour_tous/src/models/fiches/identite_fiche_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/widgets/btn_widget.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class AddConclusionFiche extends StatefulWidget {
  const AddConclusionFiche({Key? key, this.identiteFicheModel})
      : super(key: key);
  final IdentiteFicheModel? identiteFicheModel;

  @override
  State<AddConclusionFiche> createState() => _AddConclusionFicheState();
}

class _AddConclusionFicheState extends State<AddConclusionFiche> {
  final ScrollController _controllerScroll = ScrollController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // conclusion
  TextEditingController conclusionController = TextEditingController();

  String? matricule;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    conclusionController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    final user = await UserSecureStorage().readUser();
    if (!mounted) return;
    setState(() {
      matricule = user.matricule;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(title: "Id ${widget.identiteFicheModel!.id}"),
            Expanded(child: addFicheWidget())
          ],
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
                      conclusionWidget(),
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
                              changeStatut();
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

  Widget conclusionWidget() {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.all(p10),
      decoration: const BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Conclusion medicale :',
                  textAlign: TextAlign.start,
                  style: bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade700)),
            ],
          ),
          const SizedBox(height: p20),
          conclusionTextWidget()
        ],
      ),
    );
  }

  Widget conclusionTextWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: conclusionController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'conclusion medicale',
            hintText: 'conclusion medicale',
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
    final conclusionFicheModel = ConclusionFicheModel(
        identifiant: widget.identiteFicheModel!.id!,
        conclusion: conclusionController.text,
        statut: 'Ok',
        signature: matricule.toString(),
        institut: widget.identiteFicheModel!.institut,
        createdConsulsion: DateTime.now());
    await ConclusionLocal().insertData(conclusionFicheModel);
    Routemaster.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Enregistrer avec succès!"),
      backgroundColor: Colors.green[700],
    ));
  }

  Future<void> changeStatut() async {
    final identiteFicheModel = IdentiteFicheModel(
        id: widget.identiteFicheModel!.id,
        nom: widget.identiteFicheModel!.nom,
        postNom: widget.identiteFicheModel!.postNom,
        preNom: widget.identiteFicheModel!.preNom,
        sexe: widget.identiteFicheModel!.sexe,
        age: widget.identiteFicheModel!.age,
        taille: widget.identiteFicheModel!.taille,
        poids: widget.identiteFicheModel!.poids,
        tensionArterielle: widget.identiteFicheModel!.tensionArterielle,
        email: widget.identiteFicheModel!.email,
        telephone: widget.identiteFicheModel!.telephone,
        nomPere: widget.identiteFicheModel!.nomPere,
        nomMere: widget.identiteFicheModel!.nomMere,
        provinceOrigine: widget.identiteFicheModel!.provinceOrigine,
        adresse: widget.identiteFicheModel!.adresse,
        statut: 'Pres pour examen',
        signature: widget.identiteFicheModel!.signature,
        institut: widget.identiteFicheModel!.institut,
        created: widget.identiteFicheModel!.created);

    await IdentiteLocal().updateData(identiteFicheModel);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text("Statut de ${widget.identiteFicheModel!.preNom} mis à jour!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
