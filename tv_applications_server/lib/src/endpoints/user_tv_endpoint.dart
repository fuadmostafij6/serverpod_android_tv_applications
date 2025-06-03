


import 'dart:math';

import 'package:serverpod/server.dart';

import '../generated/protocol.dart';


class UserTvEndpoint extends Endpoint {


  Future<List<Media>> getAllTv(Session session, { int page =1, int tvPerPage = 10}) async {
    int pageNumber = max(1, page);
    return await Media.db.find(
      session,
      orderBy: (t) => t.id,
      where: (t) => t.type.equals(Type.channel),
      limit: tvPerPage,
      offset: (pageNumber - 1) * tvPerPage,
    );
  }
}