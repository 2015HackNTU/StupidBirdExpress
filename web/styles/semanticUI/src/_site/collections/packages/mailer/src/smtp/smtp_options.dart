part of mailer;

class SmtpOptions {
  String name = Platform.localHostname;
  String hostName;
  int port = 465;
  bool requiresAuthentication = false;
  bool ignoreBadCertificate = true;
  bool secured = false;
  String username;
  String password;
}
