{
  virtualisation.oci-containers.containers.syncthing = {
    image = "lscr.io/linuxserver/syncthing:latest";
    environment = {
      PUID = 1000;
      GUID = 1000;
    };
    volumes = [
      "/sync:/config"
    ];
    ports = [
      "127.0.0.1:8384:8384"
      "100.88.86.126:20000:20000/tcp"
      "100.88.86.126:20000:20000/udp"
      "100.88.86.126:21027:21027/udp"
    ];
  };
}
