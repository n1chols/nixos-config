{ ... }: {
  # Enable Bluetooth driver
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
