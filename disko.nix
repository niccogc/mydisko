    {
    disko.devices = {
      disk.primary = {
        device = /dev/sda;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "2G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }; 
            swap = {
              size = "16G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            rootfs = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "btrfs";
                extraArgs = [ "-f" ];
                mountpoint = "/";
                subvolumes = {
                  "/" = { mountpoint = "/"; };
                  "nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "subvol=nix" "compress=zstd" "noatime" "ssd" ];
                  };
                  "persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "subvol=persist" "compress=zstd" "noatime" "ssd" ];
                  };
                };
              };
            };
          };
        };
      };

      disk.secondary = {
        device = /dev/sdb;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            var = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "btrfs"; 
                mountpoint = "/";
                subvolumes = {
                  "var" = {
                    mountpoint = "/var";
                    mountOptions = [ "subvol=var" "noatime" "ssd" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
