{
  config,
  ...
}:
with config.lib.stylix.colors.withHashtag; ''
  * {
    font-family: "JetBrainsMono Nerd Font";
    color: #e5e9f0;
    background: transparent;
  }

  #window {
    background: ${base00};
    margin: auto;
    padding: 10px;
    border-radius: 20px;
    border: 5px solid ${base0B};
  }

  #input {
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 15px;
  }

  #outer-box {
    padding: 20px;
  }

  #img {
    margin-right: 6px;
  }

  #entry {
    padding: 10px;
    border-radius: 15px;
  }

  #entry:selected {
    background-color: ${base03};
  }

  #text {
    margin: 2px;
  }
''
