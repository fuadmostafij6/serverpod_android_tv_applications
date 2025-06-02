import 'package:serverpod/server.dart';

import '../generated/protocol.dart';



// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class MediaEndpoint extends Endpoint {
  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter.
  // `bool`, `int`, `double`, `String`, `UuidValue`, `Duration`, `DateTime`, `ByteData`,
  // and other serializable classes, exceptions and enums from your from your `protocol` directory.
  // The methods should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.

  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope.admin};
  Future<void> createTv(Session session, Media tv) async {
    await Media.db.insertRow(session, tv);
  }
  //
  Future<void> deleteTv(Session session, Media tv) async {
    await Media.db.deleteRow(session, tv);
  }

  Future<void> updateTv(Session session, Media tv) async {
    await Media.db.updateRow(session, tv);
  }

  Future<void> insertMediaList(Session session, List<Media> mediaList) async {
    for (final media in mediaList) {
      final exists = await Media.db.findFirstRow(
        session,
        where: (t) => t.url.equals(media.url),
      );

      if (exists == null) {
        await Media.db.insertRow(session, media);
      } else {
        // Optional: Update existing or skip
        print('Duplicate entry skipped: ${media.url}');
      }
    }
  }



  //
  Future<List<Media>> getAllTv(Session session, { int page =1, int tvPerPage = 10}) async {
    // By ordering by the id column, we always get the notes in the same order
    // and not in the order they were updated.
    return await Media.db.find(
      session,
      orderBy: (t) => t.id,
      limit: tvPerPage,
      offset: (page - 1) * tvPerPage,
    );
  }

}
