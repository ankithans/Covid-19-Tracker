RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

String addSeperator(String a) {
  String result = a.replaceAllMapped(reg, mathFunc);
  return result;
}
