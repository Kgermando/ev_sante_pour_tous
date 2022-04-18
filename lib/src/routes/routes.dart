import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/pages/admin/universite/add_universite.dart';
import 'package:sante_pour_tous/src/pages/admin/universite/table_universite.dart';
import 'package:sante_pour_tous/src/pages/admin/users/users_page.dart';
import 'package:sante_pour_tous/src/pages/auth/login_auth.dart';
import 'package:sante_pour_tous/src/pages/auth/profil_page.dart';
import 'package:sante_pour_tous/src/pages/auth/register.dart';
import 'package:sante_pour_tous/src/pages/fiches/antecedant/list_antecedant_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/conclusion/list_conclusion_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/examen/list_examen_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/identite/list_identite_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/stats_fiche.dart';
import 'package:sante_pour_tous/src/pages/home/home_page.dart';
import 'package:sante_pour_tous/src/pages/home/options_page.dart';
import 'package:sante_pour_tous/src/pages/screens/help_screen.dart';
import 'package:sante_pour_tous/src/pages/screens/settings_screen.dart';

import '../app_state/app_state.dart';

class UserRoutes {
  static const login = "/";
  static const register = "/register";
  static const inserUser = "/inser-user";
  static const users = "/users";
  static const profile = "/profile";
  static const helps = "/helps";
  static const settings = "/settings";
  static const splash = "/splash";
}

class HomeRoutes {
  static const home = "/home";
  static const options = "/options";
  static const stats = "/stats";
  static const identite = "/identite";
  static const antecedant = "/antecedant";
  static const examen = "/examen";
  static const conclusion = "/conclusion";
}

class AdminRoutes {
  static const tableUniv = "/tableUniv";
  static const addUniv = "/addUniv";
}

class FicheRoutes {
  static const tableFiche = "/tableFiche";
  static const addFiche = "/addFiche";
}

class Routing {
  final loggedOutRouteMap = RouteMap(
    onUnknownRoute: (route) => const Redirect(UserRoutes.login),
    routes: {
      UserRoutes.login: (_) => const MaterialPage(child: LoginPage()),
      UserRoutes.register: (_) => const MaterialPage(child: RegisterPage()),
    },
  );

  RouteMap buildRouteMap(AppState appState) {
    return RouteMap(routes: {
      UserRoutes.login: (_) => const MaterialPage(child: HomePage()),
      UserRoutes.inserUser: (_) => const MaterialPage(child: RegisterPage()),
      UserRoutes.users: (_) => const MaterialPage(child: UsersPage()),
      UserRoutes.profile: (_) => const MaterialPage(child: ProfilPage()),
      UserRoutes.helps: (_) => const MaterialPage(child: HelpScreen()),
      UserRoutes.settings: (_) => const MaterialPage(child: SettingsScreen()),
      HomeRoutes.options: (_) => const MaterialPage(child: OptionsPage()),
      AdminRoutes.tableUniv: (_) => const MaterialPage(child: TableUniversite()),
      AdminRoutes.addUniv: (_) => const MaterialPage(child: AddUniversite()),


      HomeRoutes.stats: (_) => const MaterialPage(child: StatsFiche()),
      HomeRoutes.identite: (_) => const MaterialPage(child: ListIdentiteFiche()),
      HomeRoutes.antecedant: (_) => const MaterialPage(child: ListAntecedantFiche()),
      HomeRoutes.examen: (_) => const MaterialPage(child: ListExamenFiche()),
      HomeRoutes.conclusion: (_) => const MaterialPage(child: ListConclusionFiche()),
    });
  }
}
