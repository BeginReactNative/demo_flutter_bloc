import 'package:bloc_partten/blocs/todo/todo.dart';
import 'package:flutter/material.dart';

typedef OnSave(String task, String note);

class AddEditScreen extends StatefulWidget {
  final Todo todo;
  final OnSave onSave;
  final bool isEditing;
  AddEditScreen(
      {Key key,
      @required this.todo,
      @required this.onSave,
      @required this.isEditing})
      : super(key: key);

  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  String _task;
  String _note;
    static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isEditing => widget.isEditing;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit" : "Add",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.todo.task : '',
                autofocus: !isEditing,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: "todo hint",
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? "todo error"
                      : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo.note : '',
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: "hint",
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_task, _note);
            Navigator.pop(context);
          }

        },
      ),
    );
  }
}
