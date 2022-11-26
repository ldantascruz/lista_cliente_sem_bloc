import '../models/client.dart';

class ClientsRepository {
  final List<Client> _clients = [];

  List<Client> loadClients() {
    _clients.addAll([
      Client(nome: 'José Armando'),
      Client(nome: 'Anastácia Silva'),
      Client(nome: 'Marineiva Golçalvez'),
      Client(nome: 'Bruno Marcondez'),
    ]);
    return _clients;
  }

  List<Client> addClient(Client client) {
    _clients.add(client);
    return _clients;
  }

  List<Client> removeClient(Client client) {
    _clients.remove(client);
    return _clients;
  }
}
