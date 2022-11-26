import '../models/client.dart';

abstract class ClientState {
  List<Client> clients;

  ClientState({
    required this.clients,
  });
}

class ClientInitialState extends ClientState {
  ClientInitialState() : super(clients: []);
}
 
class ClientSuccessState extends ClientState {
  ClientSuccessState({required List<Client> clients}) : super (clients: clients);
}