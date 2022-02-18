import 'package:flut_app/helper/StringHelper.dart';
import 'package:flut_app/model/Task.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  List<Task> items;

  final int index;
  
  VoidCallback callback;

  ItemList({Key? key, required this.items, required this.index, required this.callback})
      : super(key: key);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: widget.items[widget.index].completed ? Colors.green : Colors.red,
      title: Text(StringHelper.getFirstWord(widget.items[widget.index].title)),
      subtitle: Text(widget.items[widget.index].detail),
      hoverColor: Colors.blue.shade600.withOpacity(0.1),
      trailing: widget.items[widget.index].completed
          ? const Icon(Icons.done)
          : const Icon(Icons.remove),
      leading: const Icon(
        Icons.adjust,
        color: Colors.black,
        size: 30,
      ),
      onTap: () {
        var item = widget.items[widget.index];
        item.completed = !item.completed;
        setState(() => widget.items = widget.items);

      },
      onLongPress: () {
        widget.callback();
        setState(() {});

        var items = widget.items;
        items.removeAt(widget.index);
        setState(() => widget.items = items);
      },
    );
  }
}
