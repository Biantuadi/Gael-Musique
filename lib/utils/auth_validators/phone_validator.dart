String? validatePhoneNumber({String? value}) {
  final regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  if(value!.isEmpty){
    return "Le numéro de téléphone est obligatoire!";
  }

  return !regex.hasMatch(value)
      ? "Le numéro entré n'est pas valide"
      : null;
}