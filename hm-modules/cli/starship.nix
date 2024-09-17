{lib, ...}: {
  programs.starship = {
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$jobs"
        "$cmd_duration"
        "$line_break"
        "$custom"
        "$character"
      ];
      username = {
        format = "[$user]($style) ";
        show_always = true;
      };
      directory.style = "blue";
      directory.read_only = "";
      directory.read_only_style = "bold red";
      git_branch = {
        format = "[$branch]($style) ";
        style = "bright-black";
      };
      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "cyan";
      };
      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };
      jobs = {
        number_threshold = 1;
        format = "[$symbol $number]($style) ";
        symbol = "";
        style = "bold purple";
      };
      cmd_duration = {
        format = "[󰥔 $duration]($style) ";
        style = "bold bright-red";
      };
      custom.direnv = {
        format = "[󰉋 direnv]($style) ";
        style = "fg:green dimmed bold";
        when = "printenv DIRENV_FILE";
      };
      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vimcmd_symbol = "[](bold bright-black)";
        vimcmd_replace_one_symbol = "[](bold purple)";
        vimcmd_replace_symbol = "[](bold purple)";
        vimcmd_visual_symbol = "[](bold blue)";
      };
    };
  };
}
