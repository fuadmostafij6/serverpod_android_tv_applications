


import 'package:serverpod/server.dart';

import '../generated/protocol.dart';


class UserTvEndpoint extends Endpoint {


  Future<List<Media>> getAllTv(Session session, { int page =1, int tvPerPage = 10}) async {
    // By ordering by the id column, we always get the notes in the same order
    // and not in the order they were updated.
    return await Media.db.find(
      session,
      orderBy: (t) => t.id,
      where: (t) => t.type.equals(Type.channel),
      limit: tvPerPage,
      offset: (page - 1) * tvPerPage,
    );
  }
}