library mailer.args;

import 'package:args/args.dart';

class FilePathArgs{
  final String path;
  FilePathArgs(String this.path);
}

FilePathArgs parseArgsFilePath(List<String> arguments)
  => _parseFilePathArgs(arguments);

FilePathArgs _parseFilePathArgs(List<String> arguments) {
  final ArgParser parser = new ArgParser()
    ..addFlag("help", abbr: 'h', negatable: false, help: "Display this message");

  var args;
  try {
    args = parser.parse(arguments);
  } on FormatException catch (e) {
    print(e.message);
    return null;
  }

  if (args['help']) {
    print("Usage: dart [<Path>]");
    print(parser.usage);
    return null;
  }

  if (args.rest.length != 1) {
    print("the path of log file required. Use -h for help.");
    return null;
  }
  
  final String path = args.rest.first;

  return new FilePathArgs(path);
}