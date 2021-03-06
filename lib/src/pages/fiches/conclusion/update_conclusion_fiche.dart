import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/conclusion_local.dart';
import 'package:sante_pour_tous/src/helpers/user_preferences.dart';
import 'package:sante_pour_tous/src/helpers/user_secure_storage.dart';
import 'package:sante_pour_tous/src/models/fiches/conclusion_fiche_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/widgets/btn_widget.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class UpdateConclusionFiche extends StatefulWidget {
  const UpdateConclusionFiche({Key? key, this.conclusionFicheModel}) : super(key: key);
  final ConclusionFicheModel? conclusionFicheModel;

  @override
  State<UpdateConclusionFiche> createState() => _UpdateConclusionFicheState();
}

class _UpdateConclusionFicheState extends State<UpdateConclusionFiche> {
  final ScrollController _controllerScroll = ScrollController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // conclusion
  TextEditingController conclusionController = TextEditingController();

  String? matricule;

  @override
  void initState() {
    conclusionController = TextEditingController(text: widget.conclusionFicheModel!.conclusion);
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
            CustomAppbar(title: "Id ${widget.conclusionFicheModel!.identifiant}"),
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
                : MediaQuery.of(context).size.width /1.1,
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
      id: widget.conclusionFicheModel!.id,
      identifiant: widget.conclusionFicheModel!.identifiant,
      conclusion: conclusionController.text,
      statut: 'Ok',
      signature: matricule.toString(),
      institut: widget.conclusionFicheModel!.institut,
      createdConsulsion: DateTime.now());
    await ConclusionLocal().updateData(conclusionFicheModel);
    Routemaster.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Mise ?? jour effectu??e!"),
      backgroundColor: Colors.green[700],
    ));
  }
}