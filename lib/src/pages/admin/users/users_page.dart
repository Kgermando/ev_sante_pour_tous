import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/global/local/users/users_local.dart';
import 'package:sante_pour_tous/src/models/users/user_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/admin/users/update_user.dart';
import 'package:sante_pour_tous/src/routes/routes.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({ Key? key }) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
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
          child: const Icon(Icons.add),
          onPressed: () {
            Routemaster.of(context).push(UserRoutes.inserUser);
          }),
      body: Column(
        children: [
          const CustomAppbar(title: 'Utilisateurs'),
          Expanded(
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) {
                final dataList = tapEvent.row!.cells.values;
                final idPlutoRow = dataList.elementAt(0);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        UpdateUser(id: idPlutoRow.value)));

                // print("item ${idPlutoRow.value} ");
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
                    } else if (column.field == 'prenom') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'matricule') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'role') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'isOnline') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'adresse') {
                      return resolver<ClassYouImplemented>()
                          as PlutoFilterType;
                    } else if (column.field == 'createdAt') {
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
        title: 'Prenom',
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
        title: 'Matricule',
        field: 'matricule',
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
        title: 'Role',
        field: 'role',
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
        title: 'isOnline',
        field: 'isOnline',
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
        title: 'Adresse',
        field: 'adresse',
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
        field: 'createdAt',
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
    List<UserModel?> data = await UserLocal().getAllData();
    // print('agents $data');
    if (mounted) {
      setState(() {
        for (var item in data) {
          id = item!.id;
          rows.add(PlutoRow(cells: {
            'id': PlutoCell(value: item.id),
            'nom': PlutoCell(value: item.nom),
            'prenom': PlutoCell(value: item.prenom),
            'matricule': PlutoCell(value: item.matricule),
            'role': PlutoCell(value: item.role),
            'isOnline': PlutoCell(value: item.isOnline),
            'adresse': PlutoCell(value: item.adresse),
            'createdAt':
                PlutoCell(value: DateFormat("DD-MM-yy").format(item.createdAt))
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
