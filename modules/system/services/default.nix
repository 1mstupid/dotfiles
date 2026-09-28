{
  imports = [
   ./zram.nix
   ./kmonad.nix
   ./rqbit.nix
   ./suwayomi.nix
   ./wayland.nix
   ./etc.nix
   ./network.nix
   ./hosts.nix
   ./Tz.nix
   ./audio.nix
   ./bluetooth.nix
   ./boot.nix
 ];
  service.rqbit = {
    enable = true;
    openFirewall = true;
  };
}
