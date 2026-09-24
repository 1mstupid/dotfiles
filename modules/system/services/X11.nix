{config, lib, ...}:
{
 services.xserver.enable = true;
 services.xserver = {
 	enable = true;
 	autoRepeatDelay = 200;
 	autoRepeatInterval = 35;
 	windowManager.bspwm.enable = true;
 };
}
