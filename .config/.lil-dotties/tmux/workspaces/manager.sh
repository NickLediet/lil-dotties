#!/usr/bin/env bash
dir=$(dirname "$0")
source "${dir}/../../src/concent.sh"

session_name="manager"

function create_session {
  # Create the named session
  tmux new-session -d -s $session_name

  #===============================
  # ROW 1 = Main/Command prompts
  #===============================
  tmux rename-window -t 0 'main'
  tmux send-keys -t 'main' 'echo "Test"'

  #===============================
  # ROW 2
  #===============================
  # Left - Manager Local Serve (`nx run manager:serve:local`)

}

session_exists=$(tmux list-sessions | grep $session_name)



if [ "$session_exists" = "" ]; then
  
  $should_delete_session=$(
    concent "A session with the name \"${session_name}\" already exists.  Would you like to delete it?"
  )
  if $should_delete_session; then
    echo "deleting the session..."
  fi

  # create_session
fi 

# attach session to the main window
tmux attach-session -t $session_exists:0
