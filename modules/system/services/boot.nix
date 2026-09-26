{ inputs, config, ... }:{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
      kernel.sysctl = {
        "fs.inotify.max_user_instances" = 524288;
        "fs.inotify.max_user_watches" = 524288;

        "fs.protected_fifos" = 2;
        "fs.protected_hardlinks" = 1;
        "fs.protected_regular" = 2;
        "fs.protected_symlinks" = 1;

        "kernel.dmesg_restrict" = 1;
        "kernel.kptr_restrict" = 2;
        "kernel.perf_event_paranoid" = 3;
        "kernel.randomize_va_space" = 2;
        "kernel.yama.ptrace_scope" = 2;

        "net.core.bpf_jit_harden" = 1;

        "net.ipv4.conf.all.accept_source_route" = 0;
        "net.ipv4.conf.all.accept_redirects" = 0;
        "net.ipv4.conf.all.rp_filter" = 1;
        "net.ipv4.conf.default.accept_source_route" = 0;
        "net.ipv4.conf.default.accept_redirects" = 0;
        "net.ipv4.conf.default.rp_filter" = 1;

        "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
        "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
        "net.ipv4.tcp_syncookies" = 1;

        "net.ipv6.conf.all.accept_source_route" = 0;
        "net.ipv6.conf.all.accept_redirects" = 0;
        "net.ipv6.conf.default.accept_source_route" = 0;
        "net.ipv6.conf.default.accept_redirects" = 0;

        "vm.max_map_count" = 1048576;
      };

      kernelModules = [
        "amdgpu"
        "ntsync"
        "v4l2loopback"
      ];

      kernelPackages = inputs."nix-cachyos-kernel".legacyPackages.x86_64-linux.linuxPackages-cachyos-latest-lto-x86_64-v3;


      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];

      kernelParams = [
        "amdgpu.gpu_recovery=1"

        "mitigations=auto"

        "init_on_alloc=1"
        "init_on_free=1"
        "slab_nomerge"
        "page_alloc.shuffle=1"
        "vsyscall=none"
        "lsm=landlock,yama,bpf"

        "quiet"
        "splash"
      ];

      supportedFilesystems = {
        vfat = true;
        btrfs = true;
      };
  };
}
