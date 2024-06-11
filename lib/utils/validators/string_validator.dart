String? validateName({required String? value, required String emptyMessage, required String message}) {
  final regex = RegExp('[a-zA-Z]');
  if(value!.isEmpty){
    return emptyMessage;
  }
  return !regex.hasMatch(value)
      ? message
      : null;
}