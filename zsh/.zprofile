export GOPATH=~/go
export PATH="$GOPATH/bin:$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
export RUST_SRC_PATH=/home/yiqiao/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
