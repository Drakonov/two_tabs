import 'dart:collection';



import '../main.dart';

@override
extension StringExtension on String {
  String toFirstUpperCase() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

List<String> getUniques(List<String> list) {
  var input = list;
  var uniques = new LinkedHashMap<String, bool>();
  for (var s in input) {
    uniques[s] = true;
  }
  List<String> dep = [];
  for (var key in uniques.keys) {
    if (key != '') dep.add(key);
  }
  input = dep;
  uniques = new LinkedHashMap<String, bool>();
  for (var s in input) {
    uniques[s] = true;
  }
  dep = [];
  for (var key in uniques.keys) {
    if (key != '') dep.add(key);
  }
  return dep;
}

String normPhone(String _phone) {
  if (_phone.length > 0) {
    _phone = _phone.replaceAll('+', '');
    _phone = _phone.replaceAll('-', '');
    _phone = _phone.replaceAll(' ', '');
    _phone = _phone.replaceAll('(', '');
    _phone = _phone.replaceAll(')', '');
    if (_phone[0] == '8') _phone = '7' + _phone.substring(1);
    if (_phone.length == 11)
      return _phone;
    else
      return '';
  } else
    return '';
}

