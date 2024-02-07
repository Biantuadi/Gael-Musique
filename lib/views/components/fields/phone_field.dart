import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatefulWidget{
  final Function onChanged;
  final Function? validator;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final int? maxLines;
  final bool? autofocus;
  final FocusNode? focusNode;

  const CustomPhoneField({super.key, required this.onChanged,  this.validator, this.initialValue, this.prefixIcon, this.suffixIcon, required this.hintText, this.maxLines, this.autofocus, this.focusNode, required TextEditingController controller});
  @override
  CustomCustomPhoneFieldFieldState createState()=>CustomCustomPhoneFieldFieldState();
}

class CustomCustomPhoneFieldFieldState extends State<CustomPhoneField>{
  bool showText = true;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
      onChanged: (value) => widget.onChanged(value),
      initialValue: widget.initialValue,
      validator: widget.validator != null? (value) => widget.validator!(value) :null,
      cursorColor:Theme.of(context).primaryColor ,
      autofocus: widget.autofocus??false,
      focusNode: widget.focusNode,
      languageCode: 'fr',
      pickerDialogStyle: PickerDialogStyle(
        countryCodeStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
        countryNameStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
        listTileDivider: const Divider(color: Colors.white10,),
        backgroundColor: Colors.black,
        searchFieldCursorColor: Colors.white,
        searchFieldInputDecoration: inputDecoration("Recherche..."),
        width: MediaQuery.sizeOf(context).width
      ),
      decoration: inputDecoration(widget.hintText),
    );
  }
  InputDecoration inputDecoration(String hintText){
    return InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
        ),
        fillColor: Colors.grey.withOpacity(0.1),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimensions.spacingSizeSmall,
          vertical: Dimensions.spacingSizeSmall,
        ),
        filled: true,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.grey.withOpacity(0.8)),
        counter: const SizedBox(),
        border:  OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
        ),
        errorStyle:
        Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.red,
        ));
  }

}