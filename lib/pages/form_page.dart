import 'package:flutter/material.dart';
import 'package:journal/assets/my_colors.dart';

final myColors = ColorHelper();

class InputFormPage extends StatefulWidget {
  final Function? entryCreate;
  final Function? entryUpdate;
  final bool createMode;

  final String? title;
  final String? body;
  final String? id;
  final int? colourID;

  const InputFormPage({
    super.key,
    required this.createMode,
    this.entryCreate,
    this.entryUpdate,
    this.title,
    this.body,
    this.id,
    this.colourID,
  });

  @override
  State<InputFormPage> createState() => _InputFormPageState();
}

class _InputFormPageState extends State<InputFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fieldTitle = TextEditingController();
  final _fieldBody = TextEditingController();

  late int _colourID;
  late MaterialColor _colour;

  @override
  void initState() {
    super.initState();

    _fieldTitle.text = widget.title ?? "";
    _fieldBody.text = widget.body ?? "";
    _colourID = widget.colourID ?? 0;
    _colour = myColors.getColor(_colourID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.createMode ? "Add" : "Update"} Entry",
          style: const TextStyle(color: Colors.black87),
        ),
        backgroundColor: _colour[300],
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: Container(
        color: _colour[300],
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _colourPicker(),
              // Title
              _textInput(_fieldTitle, "Title"),
              // Body
              _textInput(_fieldBody, "Body", maxLines: 10),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _formCleanUp() {
    setState(() {
      _fieldTitle.clear();
      _fieldBody.clear();
    });

    Navigator.pop(context);
  }

  Widget _textInput(TextEditingController controller, title,
      {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: TextFormField(
        controller: controller,
        validator: (value) => FieldValidator.validString(value),
        decoration: InputDecoration(
            labelText: title, border: const OutlineInputBorder()),
        maxLines: maxLines,
      ),
    );
  }

  Widget _colourPicker() {
    void assingColor(int index) {
      setState(() {
        _colourID = index;
        _colour = myColors.getColor(_colourID);
      });
    }

    List<Widget> swatches = myColors.getAllColors().asMap().entries.map((el) {
      final color = myColors.getColor(el.key);

      return InkWell(
          onTap: () => assingColor(el.key),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: color.shade300,
                shape: BoxShape.circle,
                border: Border.all(color: color.shade600, width: 2)),
          ));
    }).toList();

    return Row(children: [
      const Spacer(flex: 2),
      Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: swatches,
        ),
      )
    ]);
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();

          late String msg =
              "${widget.createMode ? "Saving" : "Updating"} Entry...";

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg), duration: Duration(seconds: 2)),
          );

          Future.delayed(Duration(seconds: 2)).then((_) {
            if (widget.createMode) {
              // Creating new entry
              widget.entryCreate!(
                  title: _fieldTitle.text,
                  body: _fieldBody.text,
                  colorID: _colourID);
            } else {
              // Updating entry
              widget.entryUpdate!(
                  title: _fieldTitle.text,
                  body: _fieldBody.text,
                  id: widget.id,
                  colorID: _colourID,
                  updatedAt: DateTime.now().toString());
            }

            // Clean up form
            _formCleanUp();
          });
        }
      },
      child: Text(
        "${widget.createMode ? "Save" : "Update"} Entry",
      ),
    );
  }
}

class FieldValidator {
  static validString(String? value) {
    if (value == null || value.isEmpty) {
      return "Cannot be empty";
    }

    return null;
  }
}
