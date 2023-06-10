import 'package:akademi_bootcamp/model/event_model.dart';
import 'package:akademi_bootcamp/services/etkinlikIO_service.dart';
import 'package:flutter/material.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Etkinlikler"),
        ),
        body: const Center(child: FutureBody()));
  }
}

class FutureBody extends StatelessWidget {
  const FutureBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventModel>?>(
      future: EtkinlikIOService().fetchEventList(),
      builder: (context, AsyncSnapshot<List<EventModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              EventModel? event = snapshot.data?[index];
              return ListTile(
                leading: Image.network(event?.posterUrl ?? ''),
                title: Text(event?.name ?? ''),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return Text('Bulunamadı');
        }
      },
    );
  }
}
