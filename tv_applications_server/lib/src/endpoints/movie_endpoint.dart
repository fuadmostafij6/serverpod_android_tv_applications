import 'package:serverpod/server.dart';

import '../generated/protocol.dart';



// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class MovieEndpoint extends Endpoint {
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
  Future<void> createMovie(Session session, Movie movie) async {
    await Movie.db.insertRow(session, movie);
  }
  //
  Future<void> deleteMovie(Session session, Movie movie) async {
    await Movie.db.deleteRow(session, movie);
  }

  Future<void> updateMovie(Session session, Movie movie) async {
    await Movie.db.updateRow(session, movie);
  }


  //
  Future<List<Movie>> getAllMovie(Session session) async {
    // By ordering by the id column, we always get the notes in the same order
    // and not in the order they were updated.
    return await Movie.db.find(
      session,
      orderBy: (t) => t.id,
    );
  }

}
