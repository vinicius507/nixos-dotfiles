{
  services.glance = {
    enable = true;
    settings = {
      server = {
        host = "0.0.0.0";
        port = 8080;
      };
      theme = {
        background-color = "240 2 9";
        contrast-multiplier = 1.2;
        primary-color = "232 97 85";
        positive-color = "115 54 76";
        negative-color = "347 70 65";
      };
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {type = "calendar";}
                {
                  type = "twitch-channels";
                  channels = [
                    "casimito"
                    "gaules"
                    "theo"
                    "theprimeagen"
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {type = "hacker-news";}
                {
                  type = "videos";
                  channels = [
                    "UCUyeluBRhGPCW4rPe_UvBZQ" # ThePrimeTime
                    "UCVk4b-svNJoeytrrlOixebQ" # TheVimeagen
                    "UC4aiJNDUviw_vMhdCq5Kq1Q" # Cortes do Casimito
                    "UCG2Zgy_atWmy139L_KWiq9w" # OlaGUTI
                    "UCbRP3c757lWg9M-U7TyEkXA" # Theo
                  ];
                }
                {
                  type = "rss";
                  limit = 10;
                  collapse-after = 3;
                  cache = "3h";
                  style = "detailed-list";
                  feeds = [
                    {url = "https://selfh.st/rss";}
                    {url = "https://dotfyle.com/this-week-in-neovim/rss.xml";}
                    {url = "https://www.tabnews.com.br/recentes/rss";}
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "bookmarks";
                  groups = [
                    {
                      links = [
                        {
                          title = "Github";
                          url = "https://github.com";
                        }
                        {
                          title = "Gmail";
                          url = "https://mail.google.com/mail/u/0";
                        }
                        {
                          title = "Reddit";
                          url = "https://reddit.com";
                        }
                        {
                          title = "YouTube";
                          url = "https://youtube.com";
                        }
                      ];
                    }
                    {
                      title = "Reading";
                      links = [
                        {
                          title = "Asura Scans";
                          url = "https://asuratoon.com";
                        }
                        {
                          title = "Reaper Scans";
                          url = "https://reaperscans.com";
                        }
                      ];
                    }
                    {
                      title = "Self-hosted";
                      links = [
                        {
                          title = "Actual Budget";
                          url = "https://actual.dezano.io";
                        }
                        {
                          title = "Status";
                          url = "https://status.dezano.io";
                        }
                        {
                          title = "Traefik";
                          url = "https://traefik.dezano.io";
                        }
                      ];
                    }
                  ];
                }
                {
                  type = "releases";
                  repositories = [
                    "actualbudget/actual"
                    "binwiederhier/ntfy"
                    "glanceapp/glance"
                    "neovim/neovim"
                    "NixOS/nixpkgs"
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
