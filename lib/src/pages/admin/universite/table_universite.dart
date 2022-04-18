import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/admin/universite/detail_universite.dart';
import 'package:sante_pour_tous/src/routes/routes.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class TableUniversite extends StatefulWidget {
  const TableUniversite({Key? key}) : super(key: key);

  @override
  State<TableUniversite> createState() => _TableUniversiteState();
}

class _TableUniversiteState extends State<TableUniversite> {
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  int? id;

  @override
  initState() {
    agentsColumn();
    Timer.periodic(const Duration(seconds: 1), (t) {
      agentsRow();
      t.cancel();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Row(
            children: const [
              Icon(Icons.add),
              Icon(Icons.school_outlined),
            ],
          ),
          onPressed: () {
            Routemaster.of(context).push(AdminRoutes.addUniv);
          }),
      body: Column(
        children: [
          const CustomAppbar(title: 'Universités'),
          Expanded(
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) {
                final dataList = tapEvent.row!.cells.values;
                final idPlutoRow = dataList.elementAt(0);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailUniversite(id: idPlutoRow.value)));
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
                    if (column.field == 'name') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'sousNom') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'pays') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'province') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'email') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'telephone') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'siteweb') {
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
        title: 'name',
        field: 'name',
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
        title: 'sousNom',
        field: 'sousNom',
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
        title: 'Pays',
        field: 'pays',
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
        title: 'Province',
        field: 'province',
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
        title: 'Site Web',
        field: 'siteweb',
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
    List<UniversiteModel?> data = await UniversiteLocal().getAllData();
    // print('agents $data');
    if (mounted) {
      setState(() {
        for (var item in data) {
          id = item!.id;
          rows.add(PlutoRow(cells: {
            'id': PlutoCell(value: item.id),
            'name': PlutoCell(value: item.name),
            'sousNom': PlutoCell(value: item.sousNom),
            'pays': PlutoCell(value: item.pays),
            'province': PlutoCell(value: item.province),
            'email': PlutoCell(value: item.email),
            'telephone': PlutoCell(value: item.telephone),
            'siteweb': PlutoCell(value: item.siteweb),
            'created':
              PlutoCell(value: DateFormat("dd-MM-yy H:mm").format(item.created))
          }));
        }
        stateManager!.resetCurrentState();
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
