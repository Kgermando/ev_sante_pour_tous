import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/antecedant_local.dart';
import 'package:sante_pour_tous/src/global/local/fiches/identite_local.dart';
import 'package:sante_pour_tous/src/helpers/user_preferences.dart';
import 'package:sante_pour_tous/src/helpers/user_secure_storage.dart';
import 'package:sante_pour_tous/src/models/fiches/antecedant_fiche_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/widgets/btn_widget.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class UpdateAntecedantFiche extends StatefulWidget {
  const UpdateAntecedantFiche({Key? key, this.antecedantFicheModel})
      : super(key: key);
  final AntecedantFicheModel? antecedantFicheModel;

  @override
  State<UpdateAntecedantFiche> createState() => _UpdateAntecedantFicheState();
}

class _UpdateAntecedantFicheState extends State<UpdateAntecedantFiche> {
  final ScrollController _controllerScroll = ScrollController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // Personnels
  String? religion;
  String? etatCivil;
  String? passion;
  bool tumbakuYazolo = false;

  // Medico chirurgicaux
  bool allergies = false;
  TextEditingController allergiesTextController = TextEditingController();
  bool ista = false;
  bool diabete = false;
  bool tabac = false;
  bool alcool = false;
  bool produitsApperitifs = false;
  TextEditingController produitsApperitifsTextController =
      TextEditingController();
  bool consultationNeuroPhsychiatrique = false;
  TextEditingController consultationNeuroPhsychiatriqueTextController =
      TextEditingController();

  // Gyneco obstetrique
  TextEditingController ddrController = TextEditingController();
  String? parite;
  String? gesteNbreGrossesse;
  String? nbreAvortement;
  TextEditingController ageDernierEnfantController = TextEditingController();

  @override
  void initState() {
    getData();
    religion = widget.antecedantFicheModel!.religion;
    etatCivil = widget.antecedantFicheModel!.etatCivil;
    passion = widget.antecedantFicheModel!.passion;
    allergies = widget.antecedantFicheModel!.allergies;
    allergiesTextController = TextEditingController(text: widget.antecedantFicheModel!.allergiesText);
    ista = widget.antecedantFicheModel!.ista;
    diabete = widget.antecedantFicheModel!.diabete;
    tabac = widget.antecedantFicheModel!.tabac;
    alcool = widget.antecedantFicheModel!.alcool;
    produitsApperitifs = widget.antecedantFicheModel!.produitsApperitifs;
    produitsApperitifsTextController =
        TextEditingController(text: widget.antecedantFicheModel!.produitsApperitifsText);
    consultationNeuroPhsychiatrique = widget.antecedantFicheModel!.consultationNeuroPhsychiatrique;
    consultationNeuroPhsychiatriqueTextController = TextEditingController(
        text: widget.antecedantFicheModel!.consultationNeuroPhsychiatriqueText);
    ddrController = TextEditingController(
        text: widget.antecedantFicheModel!.ddr.toString());
    parite = widget.antecedantFicheModel!.parite;
    gesteNbreGrossesse = widget.antecedantFicheModel!.gesteNbreGrossesse;
    nbreAvortement = widget.antecedantFicheModel!.nbreAvortement;
    ageDernierEnfantController = TextEditingController(
        text: widget.antecedantFicheModel!.ageDernierEnfant);


    super.initState();
  }

  @override
  void dispose() {
    allergiesTextController.dispose();
    produitsApperitifsTextController.dispose();
    consultationNeuroPhsychiatriqueTextController.dispose();
    ddrController.dispose();
    ageDernierEnfantController.dispose();
    super.dispose();
  }

  String? matricule;
  String? sexe;

  Future<void> getData() async {
    final user = await UserSecureStorage().readUser();
    final data = await IdentiteLocal().getOneData(widget.antecedantFicheModel!.identifiant);
    if (!mounted) return;
    setState(() {
      matricule = user.matricule;
      sexe = data.sexe;
    });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(title: widget.antecedantFicheModel!.identifiant.toString()),
                Expanded(child: addFicheWidget())
              ],
            ),
          ),
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
                      personnelWidget(),
                      medocoChirurgieWidget(),
                      if(sexe != 'Homme')
                      gynecoObstretiqueWidget(),
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

  Widget personnelWidget() {
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
              Text('Antécédent personnel :'.toUpperCase(),
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
                    Expanded(child: religionWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    Expanded(child: etatCivilWidget()),
                  ],
                )
              : Column(
                  children: [religionWidget(), etatCivilWidget()],
                ),
          Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: passionWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    Expanded(child: tumbakuYazoloWidget()),
                  ],
                )
              : Column(
                  children: [passionWidget(), tumbakuYazoloWidget()],
                ),
        ],
      ),
    );
  }

  Widget religionWidget() {
    final List<String> dropdownList = ["C", "P", "M", "EKC", "KIM", "AUTRES"];
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Religion',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: religion,
        isExpanded: true,
        items: dropdownList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            religion = value!;
          });
        },
      ),
    );
  }

  Widget etatCivilWidget() {
    final List<String> dropdownList = [
      "MARIE",
      "CELIBATAIRE",
      "DIVORCE",
      "AUTRES"
    ];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Etat civil',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: etatCivil,
        isExpanded: true,
        items: dropdownList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            etatCivil = value!;
          });
        },
      ),
    );
  }

  Widget passionWidget() {
    final List<String> dropdownList = [
      "FOOTBALL",
      "BASKETBALL",
      "VOLLEY",
      "TENNIS",
      "ZANGO",
      "AUTRES"
    ];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Passion',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: passion,
        isExpanded: true,
        items: dropdownList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            passion = value!;
          });
        },
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Widget tumbakuYazoloWidget() {
    return ListTile(
      title: const Text('Tumbaku ya zolo'),
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: tumbakuYazolo,
        onChanged: (bool? value) {
          setState(() {
            tumbakuYazolo = value!;
          });
        },
      ),
    );
  }

  Widget medocoChirurgieWidget() {
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
              Text('Antécédent Medico chirurgicaux :'.toUpperCase(),
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
                    Expanded(child: allergiesWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    if (allergies) Expanded(child: allergiesTextWidget()),
                  ],
                )
              : Column(
                  children: [
                    passionWidget(),
                    if (allergies) tumbakuYazoloWidget()
                  ],
                ),
          Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: istaWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    Expanded(child: diabeteWidget()),
                  ],
                )
              : Column(
                  children: [istaWidget(), diabeteWidget()],
                ),
          Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: tabacWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    Expanded(child: alcoolWidget()),
                  ],
                )
              : Column(
                  children: [tabacWidget(), alcoolWidget()],
                ),
          Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: produitsApperitifsWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    if (produitsApperitifs)
                      Expanded(child: produitsApperitifsTextWidget()),
                  ],
                )
              : Column(
                  children: [
                    produitsApperitifsWidget(),
                    if (produitsApperitifs) produitsApperitifsTextWidget()
                  ],
                ),
          Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: consultationNeuroPhsychiatriqueWidget()),
                    const SizedBox(
                      width: p10,
                    ),
                    if (consultationNeuroPhsychiatrique)
                      Expanded(
                          child: consultationNeuroPhsychiatriqueTextWidget()),
                  ],
                )
              : Column(
                  children: [
                    consultationNeuroPhsychiatriqueWidget(),
                    if (consultationNeuroPhsychiatrique)
                      consultationNeuroPhsychiatriqueTextWidget()
                  ],
                ),
        ],
      ),
    );
  }

  Widget allergiesWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<bool> conditionList = [true, false];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Allergie',
            style: bodyMedium,
          ),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<bool>(
                      groupValue: allergies,
                      title: Text(condition ? "OUI" : "NON"),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          allergies = val!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget allergiesTextWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: allergiesTextController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Votre allergie ...',
            hintText: 'Votre allergie ...',
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

  Widget istaWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<bool> conditionList = [true, false];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ISTA",
            style: bodyMedium,
          ),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<bool>(
                      groupValue: ista,
                      title: Text(condition ? "OUI" : "NON"),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          ista = val!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget diabeteWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<bool> conditionList = [true, false];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Diabète", style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<bool>(
                      groupValue: diabete,
                      title: Text(condition ? "OUI" : "NON"),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          diabete = val!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget tabacWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<bool> conditionList = [true, false];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tabac", style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<bool>(
                      groupValue: tabac,
                      title: Text(condition ? "OUI" : "NON"),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          tabac = val!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget alcoolWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<bool> conditionList = [true, false];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Alcool", style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<bool>(
                      groupValue: alcool,
                      title: Text(condition ? "OUI" : "NON"),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          alcool = val!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget produitsApperitifsWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<bool> conditionList = [true, false];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Produits Apperitifs", style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<bool>(
                      groupValue: produitsApperitifs,
                      title: Text(condition ? "OUI" : "NON"),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          produitsApperitifs = val!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget produitsApperitifsTextWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: produitsApperitifsTextController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Votre produits appreritifs ...',
            hintText: 'Votre produits appreritifs ...',
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

  Widget consultationNeuroPhsychiatriqueWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final List<bool> conditionList = [true, false];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Consultation Neuro Phsychiatrique', style: bodyMedium),
          Wrap(
            children: conditionList
                .map((condition) => RadioListTile<bool>(
                      groupValue: consultationNeuroPhsychiatrique,
                      title: Text(condition ? "OUI" : "NON"),
                      value: condition,
                      onChanged: (val) {
                        setState(() {
                          consultationNeuroPhsychiatrique = val!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget consultationNeuroPhsychiatriqueTextWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: consultationNeuroPhsychiatriqueTextController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Votre consultation Neuro Phsychiatrique ...',
            hintText: 'Votre consultation Neuro Phsychiatrique ...',
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

  Widget gynecoObstretiqueWidget() {
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
              Text('Gyneco Obstretrique :'.toUpperCase(),
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
                    Expanded(child: ddrWidget()),
                    Expanded(child: pariteWidget()),
                  ],
                )
              : Column(
                  children: [
                    ddrWidget(),
                    pariteWidget()
                  ],
                ),
          Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: gesteNbreGrossesseWidget()),
                    Expanded(child: nbreAvortementWidget()),
                  ],
                )
              : Column(
                  children: [
                    gesteNbreGrossesseWidget(),
                    nbreAvortementWidget()
                  ],
                ),
          ageDernierEnfantWidget()
        ],
      ),
    );
  }

  Widget ddrWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DateTimePicker(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.date_range),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'DDR',
          ),
          controller: ddrController,
          firstDate: DateTime(1930),
          lastDate: DateTime(2100),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget pariteWidget() {
    var nbrList = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12"
    ];
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Parité',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: parite,
        isExpanded: true,
        items: nbrList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            parite = value!;
          });
        },
      ),
    );
  }

  Widget gesteNbreGrossesseWidget() {
    var nbrList = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12"
    ];
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Gestité',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: gesteNbreGrossesse,
        isExpanded: true,
        items: nbrList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            gesteNbreGrossesse = value!;
          });
        },
      ),
    );
  }

  Widget nbreAvortementWidget() {
    var nbrList = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12"
    ];
    return Container(
      margin: const EdgeInsets.only(bottom: p30),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Avortement',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: nbreAvortement,
        isExpanded: true,
        items: nbrList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            nbreAvortement = value!;
          });
        },
      ),
    );
  }

  Widget ageDernierEnfantWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p30),
        child: TextFormField(
          controller: ageDernierEnfantController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Age dernier enfant',
            hintText: 'Age dernier enfant',
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
    final antecedantFicheModel = AntecedantFicheModel(
      id: widget.antecedantFicheModel!.id,
      identifiant: widget.antecedantFicheModel!.identifiant,
      religion: religion.toString(),
      etatCivil: etatCivil.toString(),
      passion: passion.toString(),
      tabac: tabac,
      allergies: allergies,
      allergiesText: allergiesTextController.text,
      ista: ista,
      diabete: diabete,
      tumbakuYazolo: tumbakuYazolo,
      alcool: alcool,
      produitsApperitifs: produitsApperitifs,
      produitsApperitifsText: produitsApperitifsTextController.text,
      consultationNeuroPhsychiatrique: consultationNeuroPhsychiatrique,
      consultationNeuroPhsychiatriqueText:
          consultationNeuroPhsychiatriqueTextController.text,
      ddr: DateTime.parse(ddrController.text),
      parite: parite.toString(),
      gesteNbreGrossesse: gesteNbreGrossesse.toString(),
      nbreAvortement: nbreAvortement.toString(),
      ageDernierEnfant: ageDernierEnfantController.text,
      statut: 'Pres pour examen',
      signature: matricule.toString(),
      institut: widget.antecedantFicheModel!.institut,
      createdAntecedant: DateTime.now());
    await AntecedantLocal().updateData(antecedantFicheModel);
    Routemaster.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Mis à jour reussi!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
