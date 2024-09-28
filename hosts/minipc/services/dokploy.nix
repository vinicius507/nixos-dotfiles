{pkgs, ...}: let
  advertiseAddr = "100.85.134.13";
in {
  systemd.services.dokploy = {
    wantedBy = ["multi-user.target"];
    after = ["docker.service"];
    path = [pkgs.docker];
    script = ''
      docker swarm leave --force || true
      docker swarm init --advertise-addr ${advertiseAddr}
      echo "Swarm initialized"

      docker network rm -f dokploy-network
      docker network create --driver overlay --attachable dokploy-network
      echo "Network created"

      mkdir -p /etc/dokploy
      chmod -R 777 /etc/dokploy

      docker pull dokploy/dokploy:latest
      docker service create \
        --name dokploy \
        --replicas 1 \
        --network dokploy-network \
        --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
        --mount type=bind,source=/etc/dokploy,target=/etc/dokploy \
        --publish published=3000,target=3000,mode=host \
        --update-parallelism 1 \
        --update-order stop-first \
        -e PORT=3000 \
        -e TRAEFIK_SSL_PORT=443 \
        -e TRAEFIK_PORT=80 \
        dokploy/dokploy:latest
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
