String? validatePassword(String? value) {
  final regex = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z)(?=.*?[0-9])(?=.*?[!@#\$&*~¤£^*%€^]).{8,}$");
  if(value!.isEmpty){
    return "le mot de passe est obligatoire";
  }
  if(value.length <8){
    return "le mot de passe doit contenir au moins 8 caractères";
  }
  return !regex.hasMatch(value)
      ? 'Votre mot de passe doit contenir au moins une lettre majuscule, une lettre minuscule et des caractères spéciaux'
      : null;
}