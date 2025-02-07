{...}: {
  programs.k9s = {
    enable = true;
    plugin = {
      plugins = {
        #--- Create swissarmy debug pod in current namespace
        debug = {
          shortCut = "Shift-D";
          description = "Add debug pod";
          scopes = ["pods"];
          command = "bash";
          background = false;
          confirm = true;
          args = [
            "-c"
            "kubectl run -it -n=$NAMESPACE swissarmy --image=leodotcloud/swiss-army-knife:latest -- bash"
          ];
        };
      };
    };
  };
}
