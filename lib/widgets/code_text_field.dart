import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({
    Key? key,
    required TextEditingController textEditingController,
    required FocusNode focusNode,
    required Function(String value) onChanged,
  }) : _textEditingController = textEditingController,
        _focusNode = focusNode,
        _onChanged = onChanged,
        super(key: key);

  final TextEditingController _textEditingController;
  final FocusNode _focusNode;
  final void Function(String value) _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      focusNode: _focusNode,
      textAlign: TextAlign.center,
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      style: GoogleFonts.nunito(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      onChanged: _onChanged,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
