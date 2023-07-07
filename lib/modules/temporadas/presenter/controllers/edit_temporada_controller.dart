import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/repositories/temporadas_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EditTemporadasController extends IController {
  final SeasonsRepository _seasonsRepository;

  EditTemporadasController(this._seasonsRepository);

  TemporadaModel? temporada;

  @override
  void init(BuildContext context) {
    temporada = ModalRoute.of(context)!.settings.arguments as TemporadaModel?;
    temporada ??= TemporadaModel.empty();
    notifyListeners();
  }

  Future<void> salvarEditaDados(BuildContext context) async {
    try {
      var op = 'criado';
      if (temporada!.id == null) {
        await _seasonsRepository.creatDocument(objeto: temporada!);
      } else {
        await _seasonsRepository.updateDocument(objeto: temporada!);
        op = 'atualizado';
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Temporada $op com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
      Helps.log(e);
    }
  }
}
