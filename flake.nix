{
  inputs.shaved-ice.url = "github:n1chols/shaved-ice";

  outputs = { shaved-ice }: {
    nixosConfigurations.htpc = shaved-ice.system {
      version = "24.11";
      arch = "x86_64";
      
      hostname = "HTPC";
      timezone = "America/Los_Angeles";
      
      filesystem = {
        boot.device = "/dev/nvme0n1p1";
        root.device = "/dev/nvme0n1p2";
        swap = [{ device = "/dev/nvme0n1p3"; }]
      };
      
      modules = [
        shaved-ice.modules.networkmanager
        shaved-ice.modules.pipewire
      ];
    };
  };
}
