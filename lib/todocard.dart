import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final String title;
  final Function(String)? onTitleChanged;
  final Function()? onDelete;
  final Function() toggleItem;
  late bool _isSelected;

  TodoCard({
    required this.title,
    this.onTitleChanged,
    this.onDelete,
    required this.toggleItem,
    required bool isSelected,
    required Key key,
  })   : _isSelected = isSelected,
        super(key: key);

  bool get isSelected => _isSelected;

  set isSelected(bool newValue) {
    _isSelected = newValue;
    // Thực hiện các hành động khác khi giá trị của isSelected thay đổi ở đây
  }

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          _editTitle();
        },
        child: ListTile(
          leading: IconButton(
            onPressed: () {
              setState(() {
               widget.isSelected =  !widget.isSelected ;
                 _toggleItem();
              });
            },
            icon: Icon(
              widget.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 24,
            ),
          ),
          title: Text(widget.title),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ),
      ),
    );
  }

  void _editTitle() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Title'),
          content: TextField(
            controller: _textEditingController,
            onChanged: (newText) {
              // Cập nhật nội dung thay đổi
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                widget.onTitleChanged?.call(_textEditingController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _toggleItem() {
    setState(() {
      widget.toggleItem();
    });
  }
}
