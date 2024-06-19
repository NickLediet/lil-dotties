test_bashrc_exists() {
	assert "cat ~/.bashrc" "~/.bashrc should exist"
}

test_yq_is_installed() {
	assert_status_code 0 "${HOME}/.local/bin/yq"
}

