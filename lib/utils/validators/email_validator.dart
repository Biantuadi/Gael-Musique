String? validateEmail(String? value) {
  final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if(value!.isEmpty){
    return "L'adresse mail est obligatoire";
  }
  return !regex.hasMatch(value)
      ? 'Entrez une adresse mail valide'
      : null;
}