import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/global/local/fiches/examen_local.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/models/fiches/examen_fiche_model.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/fiches/examen/detail_examen_fiche.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class ListExamenFiche extends StatefulWidget {
  const ListExamenFiche({Key? key}) : super(key: key);

  @override
  State<ListExamenFiche> createState() => _ListExamenFicheState();
}

class _ListExamenFicheState extends State<ListExamenFiche> {
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
          const CustomAppbar(title: 'Examens'),
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
                          DetailExamenFiche(id: idPlutoRow.value)));
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
                      } else if (column.field == 'groupSanguin') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'resus') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'hbs') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'electrophoreuseHb') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'statut') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'signature') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'Etablissement') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'createdExamen') {
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
        title: 'identifiant',
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
        title: 'Group Sanguin',
        field: 'groupSanguin',
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
        title: 'Resus',
        field: 'resus',
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
        title: 'HBS',
        field: 'hbs',
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
        title: 'ElectrophoreuseHb',
        field: 'electrophoreuseHb',
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
        title: 'Statut',
        field: 'statut',
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
        title: 'Signature',
        field: 'signature',
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
        title: 'Institut',
        field: 'institut',
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
        field: 'createdExamen',
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
    List<ExamentFicheModel?> data = await ExamenLocal().getAllData();
    if (mounted) {
      setState(() {
        for (var u in univList) {
            for (var item in data) {
              if (item!.institut == u.name) {
                    rows.add(PlutoRow(cells: {
                  'id': PlutoCell(value: item.id),
                  'identifiant': PlutoCell(value: item.identifiant),
                  'groupSanguin': PlutoCell(value: item.groupSanguin),
                  'resus': PlutoCell(value: item.resus),
                  'hbs': PlutoCell(value: item.hbs),
                  'electrophoreuseHb': PlutoCell(value: item.electrophoreuseHb),
                  'statut': PlutoCell(value: item.statut),
                  'signature': PlutoCell(value: item.signature),
                  'institut': PlutoCell(value: item.institut),
                  'createdExamen': PlutoCell(
                      value: DateFormat("dd-MM-yy HH:mm").format(item.createdExamen))
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
