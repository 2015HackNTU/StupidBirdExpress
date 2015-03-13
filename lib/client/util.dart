library client.util;

String px(int n) => '${n}px';

int numParser(String lenStr, int rollback)
  => int.parse(lenStr.substring(0, lenStr.length - rollback));