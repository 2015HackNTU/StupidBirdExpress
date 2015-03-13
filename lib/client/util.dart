library client.util;

String px(int n) => '${n}px';
String pxD(double n) => '${n}px';

int numParser(String lenStr, int rollback)
  => int.parse(lenStr.substring(0, lenStr.length - rollback));

double doubleParser(String lenStr, int rollback)
  => double.parse(lenStr.substring(0, lenStr.length - rollback));