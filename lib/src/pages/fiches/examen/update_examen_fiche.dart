import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/examen_local.dart';
import 'package:sante_pour_tous/src/helpers/user_preferences.dart';
import 'package:sante_pour_tous/src/helpers/user_secure_storage.dart';
import 'package:sante_pour_tous/src/models/fiches/examen_fiche_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/widgets/btn_widget.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class UpdateExamenFiche extends StatefulWidget {
  const UpdateExamenFiche({Key? key, this.examentFicheModel}) : super(key: key);
  final ExamentFicheModel? examentFicheModel;

  @override
  State<UpdateExamenFiche> createState() => _UpdateExamenFicheState();
}

class _UpdateExamenFicheState extends State<UpdateExamenFiche> {
  final ScrollController _controllerScroll = ScrollController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // Examen ou bilan realiser
  String? groupSanguin;
  bool resus = false;
  String? hbs;
  String? electrophoreuseHb;

  @override
  void initState() {
    getData();
    groupSanguin = widget.examentFicheModel!.groupSanguin;
    resus = widget.examentFicheModel!.resus;
    hbs = widget.examentFicheModel!.hbs;
    electrophoreuseHb = widget.examentFicheModel!.electrophoreuseHb;
    super.initState();
  }

  String? matricule;

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
            CustomAppbar(
                title: "Id ${widget.examentFicheModel!.identifiant}"),
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
                      examenWidget(),
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

  Widget examenWidget() {
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
              Text('Examen ou bilan realiser :'.toUpperCase(),
                  textAlign: TextAlign.start,
                  style: bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700)),
            ],
          ),
          const SizedBox(height: p20),
          Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: groupSanguinWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    Expanded(child: resusWidget()),
                  ],
                )
              : Column(
                  children: [groupSanguinWidget(), resusWidget()],
                ),
          Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: hbsWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    Expanded(child: electrophoreuseHbWidget()),
                  ],
                )
              : Column(
                  children: [hbsWidget(), electrophoreuseHbWidget()],
                ),
        ],
      ),
    );
  }

  Widget groupSanguinWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<String> conditionList = ["A", "B", "AB", "O"];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Groupe sanguin", style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<String>(
                      groupValue: groupSanguin,
                      title: Text(condition),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          groupSanguin = val;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget resusWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<bool> conditionList = [true, false];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ressus", style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<bool>(
                      groupValue: resus,
                      title: Text(condition ? "Positif" : "Negatif"),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          resus = val!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget hbsWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<String> conditionList = ["A", "B", "C"];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("HBS", style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<String>(
                      groupValue: hbs,
                      title: Text(condition),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          hbs = val;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget electrophoreuseHbWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<String> conditionList = ["AA", "AS", "SS"];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Electrophoreuse Hb", style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<String>(
                      groupValue: electrophoreuseHb,
                      title: Text(condition),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          electrophoreuseHb = val;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Future<void> submit() async {
    final examentFicheModel = ExamentFicheModel(
        id: widget.examentFicheModel!.id,
        identifiant: widget.examentFicheModel!.identifiant,
        groupSanguin: groupSanguin.toString(),
        resus: resus,
        hbs: hbs.toString(),
        electrophoreuseHb: electrophoreuseHb.toString(),
        statut: 'Pr??s',
        signature: matricule.toString(),
        institut: widget.examentFicheModel!.institut,
        createdExamen: DateTime.now());
    await ExamenLocal().updateData(examentFicheModel);
    Routemaster.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Mise ?? jour reussie!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
