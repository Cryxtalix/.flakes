{ user, ... }:

{
  programs.git = {
    enable = true;
    userName = user.git.username;
    userEmail = user.git.email;
    signing = {
      # Get keyid with
      # gpg --list-keys --keyid-format=long "email"
      key = "1DC1F77516767602";
      signByDefault = true;
      #gpgPath = "path to gpg executable";
    };
  };
}
