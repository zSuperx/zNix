WIDTH=$(($(tmux display -p "#{pane_width}") / 2 - 10));
HEIGHT=$(tmux display -p "#{pane_height}");

if [ "$WIDTH" -gt "$HEIGHT" ]; then
  tmux split-window -h -c '#{pane_current_path}';
else
  tmux split-window -v -c '#{pane_current_path}';
fi
