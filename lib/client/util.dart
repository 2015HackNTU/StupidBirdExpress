library client.util;

String px(int n) => '${n}px';

int lengthParser(String lenStr)
  => int.parse(lenStr.substring(0, lenStr.length - 2));