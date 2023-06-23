import 'package:appwrite/models.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/erros_auth.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repositories/crendecial_repository.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart' as sdk;

class AuthController extends IController {
  final CredencialRepository _credencialRepo;
  final ServiceRoute _serviceRoute;
  final AuthService _authService;

  AuthController(
    this._credencialRepo,
    this._serviceRoute,
    this._authService,
  );
  CredencialModel? credencialModel;
  sdk.Permissions? permissions;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  void init(BuildContext context) {
    loginAutomatico(context);
    carregaCredencial();
  }

  Future<void> logar(context) async {
    try {
      await checkUsuario();
      final dataUser = await _authService.getUser();
      await validacaoPermissao(dataUser);
      _serviceRoute.user = sdk.User.fromJson(dataUser.toMap());
      _serviceRoute.permissions = permissions;
      salvaCredencial();
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainPage.route,
        (route) => false,
      );
    } catch (e) {
      sdk.Helps.log(e);
      AppHelps.confirmaDialog(
        title: ErrosAuth.erroLogin,
        content: e.toString(),
        context: context,
      );
    }
  }

  Future<Session> checkUsuario() async {
    return _authService.createSession(
      email: email.text,
      password: password.text,
    );
  }

  Future<void> validacaoPermissao(User response) async {
    final DocumentList result = await .listDocuments(
      collectionId: sdk.Permissions.collectionId,
      queries: [
        Query.equal(
          'userId',
          response.$id,
        )
      ],
    );
    if (result.total <= 0) {
      throw Exception(ErrosAuth.isNotAdmin);
    }
    final data = result.documents.first.data;
    permissions = sdk.Permissions.fromJson(data);
  }

  void carregaCredencial() {
    final ret = _credencialRepo.list();
    if (ret.isNotEmpty) {
      credencialModel = ret.first;
      email.text = credencialModel!.email;
    }
  }

  Future<void> salvaCredencial() async {
    final cred = CredencialModel(
      datetime: DateTime.now(),
      email: email.text,
    );
    await _credencialRepo.put(objeto: cred);
  }

  Future<void> loginAutomatico(context) async {
    try {
      final dataUser = await _authService.getUser();
      await validacaoPermissao(dataUser);
      _serviceRoute.user = sdk.User.fromJson(dataUser.toMap());
      _serviceRoute.permissions = permissions;
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainPage.route,
        (route) => false,
      );
    } catch (e) {
      sdk.Helps.log(e);
    }
  }
}
