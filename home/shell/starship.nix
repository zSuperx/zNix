{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = fromTOML ''
      format = """\
      $directory\
      $package\
      $container\
      $dotnet\
      $elixir\
      $elm\
      $golang\
      $haskell\
      $java\
      $julia\
      $lua\
      $nodejs\
      $ocaml\
      $perl\
      $php\
      $python\
      $ruby\
      $rust\
      $swift\
      $terraform\
      $gleam\
      $zig\
      $git_branch\
      $git_status\
      $all$line_break$shlvl"""

      [character]
      disabled = true

      [gcloud]
      disabled = true

      [shlvl]
      disabled = false
      format = "[$symbol]($style) "
      repeat = true
      repeat_offset = 1
      style = "green"
      symbol = "❯"
      threshold = 2

      [status]
      disabled = false
      format = "[<returned $status>](italic $style)"

      # Set the format for each module to ONLY show the symbol

      [package]
      format = "[$symbol]($style) "

      [nodejs]
      format = "[$symbol]($style) "

      [rust]
      format = "[$symbol]($style) "

      [python]
      format = "[$symbol]($style) "

      [golang]
      format = "[$symbol]($style) "

      [lua]
      format = "[$symbol]($style) "

      [gleam] 
      format = "[$symbol]($style) "
    '';
  };
}
