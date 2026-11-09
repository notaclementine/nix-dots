{self, ...}: {
  flake.hjemNixosModules.ACE-hyprland = {lib, ...}: {
    imports = with self.hjemNixosModules; [
      presets-hyprland
      hyprland
    ];
    custom.hyprland.extraLuaConfig =
      lib.mkOrder 501
      /*
      lua
      */
      ''
        menu = "vicinae toggle"

        hl.monitor({
            output = "eDP-1",
            mode = "1920x1080@60",
            position = "0x0",
            scale = 1,
        })
        hl.monitor({
            output = "",
            mode = "preferred",
            position = "auto",
            scale = "auto",
        })

        hl.on("hyprland.start", function()
            hl.exec_cmd("xrandr --output eDP-1 --primary")
        end)

        hl.config({
            input = {
                follow_mouse = 1,
                sensitivity = 0.3,
                touchpad = {
                    natural_scroll = true,
                    clickfinger_behavior = true,
                    disable_while_typing = false,
                },
            },
        })

        for i = 1, 10 do
            local key = i % 10
            hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
            hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
        end
      '';

    presets.hyprland = [
      "animations"
      "keybinds"
      "rules"
      "settings"
    ];
  };
}
