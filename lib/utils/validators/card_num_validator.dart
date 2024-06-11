String? validateCardNumber(String? value) {
  final regex = RegExp(r"^(?:\d[ -]*?){13,16}$");
  if(value!.isEmpty){
    return "L'adresse mail est obligatoire";
  }
  return !regex.hasMatch(value)
      ? 'Entrez une adresse mail valide'
      : null;
}