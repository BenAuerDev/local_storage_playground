import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_storage_playground/controller/db_controller.dart';
import 'package:local_storage_playground/models/flashlist.dart';

class FlashlistList extends ConsumerWidget {
  const FlashlistList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final test = ref.read(dBControllerProvider.notifier);
    final list = ref.watch(dBControllerProvider);

    print(test.db?.path);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              final integer = list.isEmpty ? 1 : list.last.id + 1;
              await ref.read(dBControllerProvider.notifier).insertFlashlist(
                    Flashlist(
                      id: integer,
                      title: 'Flashlist $integer',
                    ),
                  );
            },
            child: const Text('Insert Flashlist'),
          ),
          for (final flashlist in list)
            ListTile(
              leading: IconButton(
                onPressed: () {
                  ref
                      .read(dBControllerProvider.notifier)
                      .addItemToFlashlist(flashlist.id, 'Item');
                },
                icon: Icon(Icons.add),
              ),
              title: Column(
                children: [
                  Text(flashlist.title),
                  for (final item in flashlist.items) Text(item),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  ref
                      .read(dBControllerProvider.notifier)
                      .removeFlashlist(flashlist.id);
                },
                icon: Icon(Icons.delete),
              ),
            ),
        ],
      ),
    );
  }
}
