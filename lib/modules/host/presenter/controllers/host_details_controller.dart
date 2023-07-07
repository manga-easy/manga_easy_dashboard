import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostDetailsController extends IController {
  final HostRepository _hostRepository;

  HostDetailsController(this._hostRepository);

  HostModel? host;

  @override
  void init(BuildContext context) {
    host = ModalRoute.of(context)!.settings.arguments as HostModel?;
    host ??= HostModel.empty();
    state = StatusBuild.done;
  }

  Future<void> saveHost(BuildContext context) async {
    try {
      state = StatusBuild.loading;
      if (host!.id == null) {
        await _hostRepository.creatDocument(objeto: host!);
      } else {
        await _hostRepository.updateDocument(objeto: host!);
      }
      Navigator.pop(context);
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Host salvo com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Error',
        content: e.toString(),
        context: context,
      );
    }
    state = StatusBuild.done;
  }
}
