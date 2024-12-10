#!/usr/bin/env bash

function create_workspace_session {
    config_file_path="$1"
    shift 1;
    # shellcheck disable=SC2124
    args="$@"

    function config_query {
        query=$1
        jq -r "$query" "$config_file_path"
    }

    # Context Directory
    root_path=$(config_query '.root_path')
    session_name=$(config_query '.name')
    # Setup window name vars
    main_window_name="main"

    # Create the named session
    tmux new-session -d -s "$session_name" -n "$main_window_name" -c "$root_path"

    # Setup rows
    tmux split-window -v -t "$session_name" -b -l 66%
    tmux split-window -v -t "$session_name"

    # Setup cols
    number_of_cols=$(config_query '.cols')
    for i in $(seq 0 $((number_of_cols - 1))); 
    do
        tmux select-pane -t $(($i * 2))
        tmux split-window -h -t "$session_name"
    done

    # Build panes based off their .json config
    number_of_panes=$(config_query '.panes|length')
    pane_to_focus=""
    for i in $(seq 0 $((number_of_panes - 1)));
    do
        pane_key=".panes[$i]"
        pane_title=$(config_query "$pane_key"".title")
        pane_command=$(config_query "$pane_key"".command" | sed "s/\$ARGS/$args/")
        send_command=$(config_query "$pane_key"".sendCommand")

        should_focus=$(config_query $pane_key".focus")
        if [ "$should_focus" = "true" ]; then
        pane_to_focus=$i
        fi

        tmux select-pane -t $i
        tmux send-keys "cd $root_path && clear" C-m
        tmux send-keys "$pane_command"

        if [ "$send_command" != "false" ]; then
        tmux send-keys C-m
        fi
    done

    if [ ! "$pane_to_focus" = "" ]; then
        tmux select-pane -t "$pane_to_focus"
    fi 
}

export -f create_workspace_session