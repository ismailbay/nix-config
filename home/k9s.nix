{...}: {
  programs.k9s = {
    enable = true;
    plugin = {
      #--- Create debug container for selected pod in current namespace
      debug = {
        shortCut = "Shift-D";
        description = "Add debug container";
        scopes = ["containers"];
        command = "bash";
        background = false;
        confirm = true;
        args = [
          "-c"
          "kubectl debug -it -n=$NAMESPACE $POD --target=$NAME --image=nicolaka/netshoot:v0.11 --share-processes -- bash"
        ];
      };
    };
  };
}
