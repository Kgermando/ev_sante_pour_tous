import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/global/local/fiches/conclusion_local.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/models/fiches/conclusion_fiche_model.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/fiches/conclusion/detail_conclusion_fiche.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class ListConclusionFiche extends StatefulWidget {
  const ListConclusionFiche({Key? key, this.universiteModel}) : super(key: key);
  final UniversiteModel? universiteModel;

  @override
  State<ListConclusionFiche> createState() => _ListConclusionFicheState();
}

class _ListConclusionFicheState extends State<ListConclusionFiche> {
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
          const CustomAppbar(title: 'Conclusions'),
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
                      builder: (context) =>
                          DetailConclusionFiche(id: idPlutoRow.value)));

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
                      if (column.field == 'identifiant') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'statut') {
                        return resolver<ClassYouImplemented>()
                            as PlutoFilterType;
                      } else if (column.field == 'createdConsulsion') {
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
        title: 'Etablissement',
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
        field: 'createdConsulsion',
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
    List<ConclusionFicheModel?> data = await ConclusionLocal().getAllData();
    if (mounted) {
      setState(() {
        for (var u in univList) {
          for (var item in data) {
          if (item!.institut == u.name) {
            rows.add(PlutoRow(cells: {
            'id': PlutoCell(value: item.id),
            'identifiant': PlutoCell(value: item.identifiant),
            'statut': PlutoCell(value: item.statut),
            'signature': PlutoCell(value: item.signature),
            'institut': PlutoCell(value: item.institut),
            'createdConsulsion': PlutoCell(
                value:
                    DateFormat("dd-MM-yy HH:mm").format(item.createdConsulsion))
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
