echo "Installing dashtool..."
wget -qO- https://github.com/dashbook/dashtool/releases/download/0.3.0/dashtool_0.3.0_x86_64-unknown-linux-musl.tar.gz | tar xvz
echo DONE

mv gitignore .gitignore
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
