extension StringExtensions on String{
  String capitalize(){
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
  String replaceSpecials(){
    String string = toLowerCase();
    string = replaceBy(charList: ["é", "è", "ê", "ë"], replaceStr: "e", string: string);
    string = replaceBy(charList: ["à", "â", "ä"], replaceStr: "a", string: string);
    string = replaceBy(charList: ["î", "ï", "ì"], replaceStr: "i", string: string);
    string = replaceBy(charList: ["ô", "ò", "ö"], replaceStr: "o", string: string);
    string = replaceBy(charList: ["ü", "û", "ù"], replaceStr: "u", string: string);
    string = replaceBy(charList: ["ÿ"], replaceStr: "y", string: string);
    return string;
  }
  String groupLetters(int groupBy){
    String string = this;
    var buffer = StringBuffer();

    if(string.length>4){
     for(int i=0; i<string.length; i++){
        buffer.write(string[i]);
        if((i+1)%groupBy==0 &&  i!= string.length-1 ){
         buffer.write(' ');
        }
      }
    }
    return buffer.toString();
  }

}

String replaceBy({required List<String> charList,required String replaceStr, required String string}){
  String str = string;
  for (String s in charList){
    if( str.contains(s) ) {
      str = str.replaceAll(s, replaceStr);
    }
  }

  return str;
}