{
  description = ''Nim wrapper for wyhash'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-wyhash-main.flake = false;
  inputs.src-wyhash-main.owner = "jackhftang";
  inputs.src-wyhash-main.ref   = "refs/heads/main";
  inputs.src-wyhash-main.repo  = "wyhash.nim";
  inputs.src-wyhash-main.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-wyhash-main"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-wyhash-main";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}