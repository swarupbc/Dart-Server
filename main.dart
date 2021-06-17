import 'dart:io';
import 'dart:convert';

List userList = [
  {"name": "Swarup Bhanja", "id": "swarup13101999"},
  {"name": "Don Joe", "id": "donjeo32323"},
  {"name": "Superman", "id": "dsaw343434e"},
  {"name": "Batman", "id": "dr34343rerere"},
  {"name": "Antman", "id": "daser434343"},
];

main() async {
  var server = await HttpServer.bind("127.0.0.1", 3000);
  print("server started at ${server.address}:${server.port}");

  server.listen((HttpRequest req) {
    print(req.uri);

    switch (req.uri.toString()) {
      // request initial route
      case '/':
        initRouter(req);
        break;
      // request initial route
      case '/addUser':
        addUser(req);
        break;
      // request initial route

      default:
        if (req.uri.toString().startsWith('/addUser')) {
          addUser(req);
          break;
        }
    }
  });
}

initRouter(HttpRequest req) {
  var encodedData = jsonEncode(userList);

  req.response.headers.contentType =
      ContentType('application', 'json', charset: 'utf-8');
  req.response.write(encodedData);
  req.response.close();
}

addUser(HttpRequest req) {
  //Parse the query string
  var uri = Uri.parse(req.uri.toString());

  var data = {
    "name": (uri.queryParameters['user']),
    "id": '323rr453454f',
  };
  userList.add(data);

  // var encodedData = jsonEncode({"message": (uri.queryParameters['user'])});

  req.response.headers.contentType =
      ContentType('application', 'json', charset: 'utf-8');
  Uri redirectUrl = Uri.http('localhost:3000', '/');
  req.response.redirect(redirectUrl);
  // req.response.write(encodedData);
  // req.response.close();
}
