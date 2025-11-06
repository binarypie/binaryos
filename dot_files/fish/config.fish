if status is-interactive
    # Commands to run in interactive sessions can go here

    # VIM Mode
    fish_vi_key_bindings

    # Editor
    set -gx EDITOR nvim

    # Prompt
    set --global hydro_multiline true
    set --global fish_prompt_pwd_dir_length 100
    set --global hydro_color_pwd $fish_color_comment
    set --global hydro_color_git $fish_color_operator
    set --global hydro_color_error $fish_color_error
    set --global hydro_color_prompt $fish_color_command
    set --global hydro_color_duration $fish_color_param

    # Env Variables
    set -Ux GOOGLE_CLOUD_PROJECT ibexio-src

    # Path
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.npm-packages/bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/Code/flutter/bin
    fish_add_path $HOME/go/bin

    # Alias
    alias wezterm 'flatpak run org.wezfurlong.wezterm'
end

### bling.fish source start
test -f /usr/share/ublue-os/bluefin-cli/bling.fish && source /usr/share/ublue-os/bluefin-cli/bling.fish
### bling.fish source end
