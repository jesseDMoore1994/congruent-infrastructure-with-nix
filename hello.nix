let
  this-file = builtins.toString ./hello.nix;
in "Hello from ${this-file}!"
