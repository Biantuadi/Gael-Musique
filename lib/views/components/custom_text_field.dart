
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget{
  final Function onChanged;
  final Function? validator;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final int? maxLines;
  final bool? autofocus;
  final FocusNode? focusNode;
  const CustomTextField({super.key, required this.onChanged,  this.validator, this.initialValue, this.prefixIcon, this.suffixIcon, required this.hintText, this.maxLines, this.autofocus, this.focusNode, required TextEditingController controller});
  @override
  CustomTextFieldState createState()=>CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField>{
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return TextFormField(
      style: Theme.of(context).textTheme.bodySmall,
      onChanged: (value) => widget.onChanged(value),
      initialValue: widget.initialValue,
      maxLines: widget.maxLines,
      validator: widget.validator != null? (value) => widget.validator!(value) :null,
      cursorColor:Theme.of(context).primaryColor ,
      autofocus: widget.autofocus??false,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(themeProvider.radiusSizeDefault)
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          fillColor: Colors.grey.withOpacity(0.1),
          contentPadding: EdgeInsets.symmetric(
            horizontal: themeProvider.spacingSizeDefault,
            vertical: themeProvider.spacingSizeDefault,
          ),
          filled: true,
          hintText: widget.hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).primaryColor),
          counter: const SizedBox(),
          border:  OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(themeProvider.radiusSizeDefault)
          ),
          errorStyle:
          Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.red,
          )),
    );
  }

}