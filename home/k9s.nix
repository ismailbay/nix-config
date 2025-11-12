{...}: {
  programs.k9s = {
    enable = true;
    plugins = {
      plugins = {
        #--- create swissarmy debug pod in current namespace
        swissarmy = {
          shortCut = "Shift-K";
          description = "Add debug pod";
          scopes = ["pods"];
          command = "bash";
          background = false;
          confirm = true;
          args = [
            "-c"
            "kubectl run --kubeconfig=$KUBECONFI swissarmyknife -it --context $CONTEXT -n=$NAMESPACE --image=leodotcloud/swiss-army-knife:latest -- bash"
          ];
        };
        #--- create ephemeral debug container in current pod
        debug = {
          shortCut = "Shift-L";
          description = "Add debug container";
          dangerous = true;
          scopes = ["containers"];
          command = "bash";
          background = false;
          confirm = true;
          args = [
            "-c"
            "kubectl --kubeconfig=$KUBECONFIG debug -it --context $CONTEXT -n=$NAMESPACE $POD --target=$NAME --image=nicolaka/netshoot:v0.13 --share-processes -- bash"
          ];
        };
        watch-events = {
          shortCut = "Shift-E";
          confirm = false;
          description = "Get Events";
          scopes = ["all"];
          command = "sh";
          background = false;
          args = [
            "-c"
            "kubectl events --context $CONTEXT --namespace $NAMESPACE --for $RESOURCE_NAME.$RESOURCE_GROUP/$NAME --watch"
          ];
        };
        argocd = {
          shortCut = "Shift-A";
          description = "Sync ArgoCD Application";
          scopes = ["application"];
          command = "argocd";
          args = [
            "app"
            "sync"
            "$NAME"
            "--app-namespace"
            "$NAMESPACE"
          ];
          background = true;
          confirm = true;
        };
      };
    };
  };
}
