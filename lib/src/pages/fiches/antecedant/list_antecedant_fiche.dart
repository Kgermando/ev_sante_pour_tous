import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/global/local/fiches/antecedant_local.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/models/fiches/antecedant_fiche_model.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/fiches/antecedant/detail_antecedant_fiche.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class ListAntecedantFiche extends StatefulWidget {
  const ListAntecedantFiche({Key? key}) : super(key: key);

  @override
  State<ListAntecedantFiche> createState() => _ListAntecedantFicheState();
}

class _ListAntecedantFicheState extends State<ListAntecedantFiche> {
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
      body: Column(
        children: [
          const CustomAppbar(title: 'Antecedants'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(p10),
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) {
                  final dataList = tapEvent.row!.cells.values;
                  final idPlutoRow = dataList.elementAt(0);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailAntecedantFiche(id: idPlutoRow.value)));
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
                      if (column.field == 'identifiant') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'etatCivil') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'passion') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'tumbakuYazolo') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'allergies') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'ista') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'diabete') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'tabac') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'alcool') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'produitsApperitifs') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field ==
                          'consultationNeuroPhsychiatrique') {
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
        title: 'Identifiant',
        field: 'identifiant',
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
        title: 'Etat Civil',
        field: 'etatCivil',
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
        title: 'Passion',
        field: 'passion',
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
        title: 'Yumbaku Ya zolo',
        field: 'tumbakuYazolo',
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
        title: 'Allergies',
        field: 'allergies',
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
        title: 'ISTA',
        field: 'ista',
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
        title: 'Diabete',
        field: 'diabete',
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
        title: 'Tabac',
        field: 'tabac',
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
        title: 'Alcool',
        field: 'alcool',
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
        title: 'Produits Apperitifs',
        field: 'produitsApperitifs',
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
        title: 'ConsultationNeuroPhsychiatrique',
        field: 'consultationNeuroPhsychiatrique',
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
    List<AntecedantFicheModel?> data = await AntecedantLocal().getAllData();

    if (mounted) {
      setState(() {
        for (var u in univList) {
          for (var item in data) {
            if (item!.institut == u.name) {
                rows.add(PlutoRow(cells: {
                'id': PlutoCell(value: item.id),
                'identifiant': PlutoCell(value: item.identifiant),
                'religion': PlutoCell(value: item.religion),
                'etatCivil': PlutoCell(value: item.etatCivil),
                'passion': PlutoCell(value: item.passion),
                'tumbakuYazolo': PlutoCell(value: item.tumbakuYazolo),
                'allergies': PlutoCell(value: item.allergies),
                'allergiesText': PlutoCell(value: item.allergiesText),
                'ista': PlutoCell(value: item.ista),
                'diabete': PlutoCell(value: item.diabete),
                'tabac': PlutoCell(value: item.tabac),
                'alcool': PlutoCell(value: item.alcool),
                'produitsApperitifs': PlutoCell(value: item.produitsApperitifs),
                'consultationNeuroPhsychiatrique':
                    PlutoCell(value: item.consultationNeuroPhsychiatrique),
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
