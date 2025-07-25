WIDTH=$(($(tmux display -p "#{pane_width}") / 2 - 10));
HEIGHT=$(tmux display -p "#{pane_height}");

if [ "$WIDTH" -gt "$HEIGHT" ]; then
  tmux split-window -h;
else
  tmux split-window -v;
fi
