import 'package:dashboard_manga_easy/core/interfaces/service.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/pages/comic_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/pages/edit_chapter_comic_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/pages/edit_comic_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/pages/edit_content_chapter_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/banners_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/criar_banners_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/detalhes_emblemas_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/forbiden_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/main_screen.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/views/cria_edita_emblema_page.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/views/emblemas_page.dart';
import 'package:dashboard_manga_easy/modules/enquente/presenter/ui/pages/edit_enquete_page.dart';
import 'package:dashboard_manga_easy/modules/enquente/presenter/ui/pages/enquete_page.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/pages/mangas_pages.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/send_notification_page.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/edit_permissoes_page.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/permissoes_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/splash/views/splash_view.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/ui/pages/edit_temporada_page.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/ui/pages/temporada_page.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/edite_nivel_user.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/user_detalhe_page.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class ServiceRoute extends IService {
  bool isInicialize = false;
  User? user;
  Permissions? permissions;
  final levelAdmin = 80;
  @override
  Future<void> initialise() async {
    isInicialize = true;
  }

  Route<MaterialPageRoute>? generationRoutes(RouteSettings settings) {
    //verifica se foi inicializado os modulos
    if (!isInicialize) {
      return MaterialPageRoute(
        builder: (_) => const SplashPage(),
        settings: settings,
      );
    }
    //verifica se está logado
    if (user == null) {
      return MaterialPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
    }
    //acesso ao pessoal comun do dashboard (parceiros, autores e outros)
    switch (settings.name) {
      case MainPage.route:
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
          settings: settings,
        );
      case MangasPage.route:
        return MaterialPageRoute(
          builder: (_) => const MangasPage(),
          settings: settings,
        );
      case ComicAuthorialPage.route:
        return MaterialPageRoute(
          builder: (_) => const ComicAuthorialPage(),
          settings: settings,
        );
      case EditComicAuthorialPage.route:
        return MaterialPageRoute(
          builder: (_) => const EditComicAuthorialPage(),
          settings: settings,
        );
      case EditChapterComicPage.route:
        return MaterialPageRoute(
          builder: (_) => const EditChapterComicPage(),
          settings: settings,
        );
      case EditContentChapterPage.route:
        return MaterialPageRoute(
          builder: (_) => const EditContentChapterPage(),
          settings: settings,
        );
    }
    //somnte admin podem acessar as rotas abaixo
    if (permissions!.value < levelAdmin) {
      return MaterialPageRoute(
        builder: (_) => const ForbidenPage(),
        settings: settings,
      );
    }
    switch (settings.name) {
      case UsersPage.route:
        return MaterialPageRoute(
          builder: (_) => const UsersPage(),
          settings: settings,
        );
      case UserDetalhesPage.route:
        return MaterialPageRoute(
          builder: (_) => const UserDetalhesPage(),
          settings: settings,
        );
      case CriarRecomendacaoPage.route:
        return MaterialPageRoute(
          builder: (_) => const CriarRecomendacaoPage(),
          settings: settings,
        );
      case RecomendacaoPage.route:
        return MaterialPageRoute(
          builder: (_) => const RecomendacaoPage(),
          settings: settings,
        );
      case NotificacaoPage.route:
        return MaterialPageRoute(
          builder: (_) => const NotificacaoPage(),
          settings: settings,
        );
      case EmblemasPage.route:
        return MaterialPageRoute(
          builder: (_) => const EmblemasPage(),
          settings: settings,
        );
      case CriaEditaEmblemaPage.route:
        return MaterialPageRoute(
          builder: (_) => const CriaEditaEmblemaPage(),
          settings: settings,
        );
      case DetalhesEmblemasPage.route:
        return MaterialPageRoute(
          builder: (_) => const DetalhesEmblemasPage(),
          settings: settings,
        );
      case CriarBannerPage.route:
        return MaterialPageRoute(
          builder: (_) => const CriarBannerPage(),
          settings: settings,
        );
      case BannerPage.route:
        return MaterialPageRoute(
          builder: (_) => const BannerPage(),
          settings: settings,
        );
      case PermissoesPage.route:
        return MaterialPageRoute(
          builder: (_) => const PermissoesPage(),
          settings: settings,
        );
      case EditPermissoesPage.route:
        return MaterialPageRoute(
          builder: (_) => const EditPermissoesPage(),
          settings: settings,
        );
      case SendNotificationPage.route:
        return MaterialPageRoute(
          builder: (_) => const SendNotificationPage(),
          settings: settings,
        );
      case TemporadasPage.route:
        return MaterialPageRoute(
          builder: (_) => const TemporadasPage(),
          settings: settings,
        );
      case EditTemporadasPage.route:
        return MaterialPageRoute(
          builder: (_) => const EditTemporadasPage(),
          settings: settings,
        );
      case EnquetePage.route:
        return MaterialPageRoute(
          builder: (_) => const EnquetePage(),
          settings: settings,
        );
      case EditEnquetePage.route:
        return MaterialPageRoute(
          builder: (_) => const EditEnquetePage(),
          settings: settings,
        );
      case EditeNivelUserPage.route:
        return MaterialPageRoute(
          builder: (_) => const EditeNivelUserPage(),
          settings: settings,
        );
      default:
        return null;
    }
  }

  List<String> menuRoutes() {
    if (permissions!.value >= levelAdmin) {
      return [
        MainPage.route,
        UsersPage.route,
        RecomendacaoPage.route,
        NotificacaoPage.route,
        EmblemasPage.route,
        BannerPage.route,
        MangasPage.route,
        PermissoesPage.route,
        TemporadasPage.route,
        EnquetePage.route,
        ComicAuthorialPage.route,
      ];
    }
    return [
      MainPage.route,
      MangasPage.route,
      ComicAuthorialPage.route,
    ];
  }
}
