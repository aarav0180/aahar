
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';
    if (length == 1) return toUpperCase();
    return '${substring(0, 1).toUpperCase()}${substring(1)}';
  }


}


extension NullableStringExtension on String? {

   bool get isNotNullAndEmpty {
    if(this == null || this == "")return false;
    return true;
  }

   bool get isNullOrEmpty => !isNotNullAndEmpty;

}



