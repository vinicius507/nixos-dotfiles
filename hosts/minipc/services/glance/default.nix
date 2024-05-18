{
  virtualisation.oci-containers.containers.glance = {
    image = "glanceapp/glance:v0.4.0";
    environment = {
      TZ = "America/Sao_Paulo";
    };
    ports = [
      "100.85.134.13:8080:8080"
    ];
    volumes = [
      "${./glance.yml}:/app/glance.yml"
      "/etc/localtime:/etc/localtime:ro"
    ];
  };
}
