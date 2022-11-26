import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lista_cliente_sem_bloc/blocs/client_bloc.dart';
import 'package:lista_cliente_sem_bloc/blocs/client_events.dart';
import 'package:lista_cliente_sem_bloc/blocs/client_state.dart';

import 'models/client.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final clientList = [];
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.inputClient.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.inputClient.close();
    super.dispose();
  }

  String randomName() {
    final rand = Random();
    return ['Maria Almeida', 'Vinicius Silva', 'Luiz Williams', 'Bianca Nevis']
        .elementAt(rand.nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Clientes'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                bloc.inputClient.add(
                  AddClientEvent(
                    client: Client(
                      nome: randomName(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
          ),
          child: StreamBuilder<ClientState>(
              stream: bloc.stream,
              builder: (context, AsyncSnapshot<ClientState> snapshot) {
                final clientsList = snapshot.data?.clients ?? [];
                return ListView.separated(
                  itemCount: clientsList.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Text(clientsList[index].nome.substring(0, 1)),
                      ),
                    ),
                    title: Text(clientsList[index].nome),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        bloc.inputClient.add(
                          RemoveClientEvent(
                            client: clientsList[index],
                          ),
                        );
                      },
                    ),
                  ),
                  separatorBuilder: (_, __) => const Divider(),
                );
              }),
        ),
      ),
    );
  }
}
