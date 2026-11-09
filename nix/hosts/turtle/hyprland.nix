{self, ...}: {
  flake.hjemNixosModules.turtle-hyprland = {lib, ...}: {
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
            output = "DP-1",
            mode = "1920x1080@144",
            position = "0x0",
            scale = 1,
            vrr = 2,
        })

        hl.monitor({
            output = "HDMI-A-1",
            mode = "1920x1080@60",
            position = "-1920x0",
            scale = 1,
        })

        hl.monitor({
            output = "",
            mode = "preferred",
            position = "auto",
            scale = "auto",
        })

        hl.on("hyprland.start", function()
            hl.exec_cmd("xrandr --output DP-1 --primary")
        end)

        hl.config({
            input = {
                accel_profile = "flat",
                follow_mouse = 1,
                kb_layout = "gb",
                sensitivity = 0.5,
            },
        })

        for i = 1, 10 do
            local key = i % 10
            if i % 2 == 1 then
                hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1" })
            else
                hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1" })
            end
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
