import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/filtro_notificacao.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract interface class NotificacaoRepository {
  Future<void> sendMessage({required Notificacao objeto});

  Future<void> deletDocument({required String id});

  Future<Notificacao?> getDocument({required String id});

  Future<void> updateDocument({required Notificacao objeto});

  Future<List<Notificacao>> listDocument({FiltroNotificacao? where});
}
