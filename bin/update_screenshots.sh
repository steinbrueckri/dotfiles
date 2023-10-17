#!/bin/bash

if [[ -n $TMUX ]]; then
  echo "💣 Script dont work in a tmux, please close at tmux sessions and try again!"
  exit 255
fi

# screenshot-1
tmux new-session -d -s demo -d
tmux split-window -t "demo:1" -h
tmux split-window -t "demo:1" -v

tmux send-keys -t "demo:1.1" 'cd Projects/3rd-party/prometheus/ && ls -la' Enter
tmux send-keys -t "demo:1.2" 'clear && neofetch' Enter
tmux send-keys -t "demo:1.3" 'kitty icat ~/.dotfileassets/me.jpg' Enter

sh -c "sleep 4; tmux kill-session" &
screencapture -T2 .dotfileassets/screenshot-1.png &

tmux attach -tdemo

# screenshot-2
tmux new-session -d -s demo -d
tmux split-window -t "demo:1" -h

tmux send-keys -t "demo:1.1" 'clear' Enter
tmux send-keys -t "demo:1.1" 'cd Projects/3rd-party/prometheus/' Enter
tmux send-keys -t "demo:1.1" 'vim' Enter
tmux send-keys -t "demo:1.2" 'cd Projects/3rd-party/prometheus/' Enter
tmux send-keys -t "demo:1.2" 'tig' Enter
tmux send-keys -t "demo:1.2" Enter

sh -c "sleep 4; tmux kill-session" &
screencapture -T2 .dotfileassets/screenshot-2.png &

tmux attach -tdemo
