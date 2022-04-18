import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/global/local/fiches/identite_local.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/models/fiches/identite_fiche_model.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/fiches/identite/add_identite_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/identite/detail_identite_fiche.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class ListIdentiteFiche extends StatefulWidget {
  const ListIdentiteFiche({Key? key}) : super(key: key);


  @override
  State<ListIdentiteFiche> createState() => _ListIdentiteFicheState();
}

class _ListIdentiteFicheState extends State<ListIdentiteFiche> {
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  int? id;

  @override
  initState() {
    getData();
    agentsColumn();
    Timer.periodic(const Duration(seconds: 1), (t) {
      agentsRow();
      t.cancel();
    });
    super.initState();
  }

  List<UniversiteModel> univList = [];

  Future<void> getData() async {
    final dataUniv = await UniversiteLocal().getAllData();
    if (!mounted) return;
    setState(() {
      univList = dataUniv;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.person_add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddIdentiteFiche()));
          }),
      body: Column(
        children: [
          const CustomAppbar(title: 'Identités'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(p10),
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) {
                  final dataList = tapEvent.row!.cells.values;
                  final idPlutoRow = dataList.elementAt(0);

                  // Routemaster.of(context).push(RhRoutes.rhAgentPage);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailIdentiteFiche(id: idPlutoRow.value)));

                  print("item ${idPlutoRow.value} ");
                },
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager!.setShowColumnFilter(true);
                },
                createHeader: (PlutoGridStateManager header) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [PrintWidget(onPressed: () {})],
                  );
                },
                configuration: PlutoGridConfiguration(
                  columnFilterConfig: PlutoGridColumnFilterConfig(
                    filters: const [
                      ...FilterHelper.defaultFilters,
                      // custom filter
                      ClassYouImplemented(),
                    ],
                    resolveDefaultColumnFilter: (column, resolver) {
                      if (column.field == 'nom') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'postNom') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'prenom') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'email') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'telephone') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'sexe') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'age') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'taille') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'poids') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'tensionArterielle') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'provinceOrigine') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      }
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void agentsColumn() {
    columns = [
      PlutoColumn(
        readOnly: true,
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.number(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 100,
        minWidth: 80,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Nom',
        field: 'nom',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Post-Nom',
        field: 'postNom',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Prénom',
        field: 'prenom',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Email',
        field: 'email',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Téléphone',
        field: 'telephone',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Sexe',
        field: 'sexe',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Age',
        field: 'age',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Taille',
        field: 'taille',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Poids',
        field: 'poids',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Tension Arterielle',
        field: 'tensionArterielle',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Province origine',
        field: 'provinceOrigine',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Date',
        field: 'created',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
    ];
  }

  Future agentsRow() async {
    List<IdentiteFicheModel?> data = await IdentiteLocal().getAllData();
    if (mounted) {
      setState(() {
        for (var u in univList) {
          for (var item in data) {
            if (item!.institut == u.name) {
                rows.add(PlutoRow(cells: {
                'id': PlutoCell(value: item.id),
                'nom': PlutoCell(value: item.nom),
                'postNom': PlutoCell(value: item.postNom),
                'prenom': PlutoCell(value: item.preNom),
                'email': PlutoCell(value: item.email),
                'telephone': PlutoCell(value: item.telephone),
                'sexe': PlutoCell(value: item.sexe),
                'age': PlutoCell(value: item.age),
                'taille': PlutoCell(value: item.taille),
                'poids': PlutoCell(value: item.poids),
                'tensionArterielle': PlutoCell(value: item.tensionArterielle),
                'provinceOrigine': PlutoCell(value: item.provinceOrigine),
                'created':
                    PlutoCell(value: DateFormat("dd-MM-yy HH:mm").format(item.created))
              }));
              stateManager!.resetCurrentState();
            }
          } 
        }
        
        
      });
    }
  }
}

class ClassYouImplemented implements PlutoFilterType {
  @override
  String get title => 'recherche';

  @override
  get compare => ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        var keys = search!.split(',').map((e) => e.toUpperCase()).toList();

        return keys.contains(base!.toUpperCase());
      };

  const ClassYouImplemented();
}
