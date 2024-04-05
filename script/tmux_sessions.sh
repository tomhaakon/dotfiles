#!/bin/bash

SESSION="workSession"

if ! tmux has-session -t $SESSION 2>/dev/null; then
  tmux new-session -d -s $SESSION -n Vim

  tmux new-window -t $SESSION -n Psdev
  #tmux send-keys -t $SESSION:Vim 'vim' C-m

  tmux new-window -t $SESSION -n Terminal

  tmux send-keys -t $SESSION:Psdev 'cd /var/www/html/psdev' C-m
  # tmux send-keys -t $SESSION:Terminal 'your-command-here' C-m
fi

# Attach to the session and start with the Vim window
tmux attach-session -t $SESSION:Vim

