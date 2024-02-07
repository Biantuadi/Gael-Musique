import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
  final bool? isForPassword;
  final bool? isForChat;
  final TextInputType? textInputType;
  const CustomTextField({super.key, required this.onChanged,  this.validator, this.initialValue, this.prefixIcon, this.suffixIcon, required this.hintText, this.maxLines, this.autofocus, this.focusNode, required TextEditingController controller, this.isForPassword, this.isForChat, this.textInputType});
  @override
  CustomTextFieldState createState()=>CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField>{
  bool showText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
      onChanged: (value) => widget.onChanged(value),
      initialValue: widget.initialValue,
      keyboardType: widget.textInputType??TextInputType.text,
      maxLines: widget.isForChat == true ? widget.maxLines : 1,
      validator: widget.validator != null? (value) => widget.validator!(value) :null,
      cursorColor:Theme.of(context).primaryColor ,
      autofocus: widget.autofocus??false,
      focusNode: widget.focusNode,
      //obscuringCharacter: "*",
      obscureText:(widget.isForPassword == true)? showText: false,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
          ),

          prefixIcon: widget.prefixIcon,
          suffixIcon:widget.isForPassword == true ? IconButton(onPressed: (){
            setState(() {
              showText = !showText;
            });
          }, icon: Icon(showText ? Iconsax.eye : Iconsax.eye_slash, color: Colors.white,)): widget.suffixIcon,
          fillColor: Colors.grey.withOpacity(0.1),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.spacingSizeDefault,
            vertical: Dimensions.spacingSizeDefault,
          ),
          filled: true,
          hintText: widget.hintText,
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
          ),
        errorMaxLines: 3
      ),

    );
  }

}