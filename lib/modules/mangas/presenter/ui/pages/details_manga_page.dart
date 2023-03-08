import 'package:coffee_cup/features/cards/image_card/ui/coffee_manga_cover.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/details_manga_controller.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/organisms/section_genders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class DetailsMangaPage extends StatefulWidget {
  const DetailsMangaPage({super.key});

  @override
  State<DetailsMangaPage> createState() => _DetailsMangaPageState();
}

class _DetailsMangaPageState extends State<DetailsMangaPage> {
  final DetailsMangaController ct = di();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    ct.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar ${ct.uniqueid}'),
      ),
      body: Builder(
        builder: (context) {
          switch (ct.state) {
            case StatusBuild.done:
              return Container(
                margin: const EdgeInsets.all(AppTheme.defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultPadding),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CoffeeMangaCover(
                          filtraImg: true,
                          height: 200,
                          width: 100,
                          cover: ct.manga!.thumb,
                          headers: Global.header,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: ct.manga!.name));
                      },
                      child: Text(
                        'Nome: ${ct.manga!.name}',
                      ),
                    ),
                    CampoPadraoAtom(
                      hintText: 'Capa',
                      onChange: (v) => ct.manga!.thumb = v,
                      initialValue: ct.manga!.thumb,
                    ),
                    const SizedBox(height: AppTheme.defaultPadding),
                    CampoPadraoAtom(
                      hintText: 'Autor',
                      onChange: (v) => ct.manga!.autor = v,
                      initialValue: ct.manga!.autor,
                    ),
                    const SizedBox(height: AppTheme.defaultPadding),
                    CampoPadraoAtom(
                      hintText: 'scans',
                      onChange: (v) => ct.manga!.scans = v,
                      initialValue: ct.manga!.scans,
                    ),
                    const SizedBox(height: AppTheme.defaultPadding),
                    CampoPadraoAtom(
                      hintText: 'Sinopse',
                      onChange: (v) => ct.manga!.sinopse = v,
                      numberLines: 5,
                      initialValue: ct.manga!.sinopse,
                    ),
                    const SizedBox(height: AppTheme.defaultPadding),
                    SectionGenders(genders: ct.manga!.generos.split('<>')),
                    const SizedBox(height: AppTheme.defaultPadding),
                    ButtonPadraoAtom(
                      title: 'Salvar',
                      icone: Icons.create,
                      onPress: ct.updateManga,
                    ),
                  ],
                ),
              );

            case StatusBuild.loading:
              return const LoadingAtom();
            case StatusBuild.erro:
              return Container();
            case StatusBuild.initial:
              return Container();
          }
        },
      ),
    );
  }
}
