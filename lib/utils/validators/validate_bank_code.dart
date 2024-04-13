bool validateCardNumber(String cardNumber){
  bool isDouble = false;
  int sum = 0;
  for(int i=cardNumber.length-1; i>=0; i--){
    int num = int.parse(cardNumber[i]);
    if(isDouble == true){
      num *= 2;
      if(num>9){
        num -= 9;
      }
    }
    sum += num;
    isDouble = !isDouble;
  }
  return sum %10 == 0;
}