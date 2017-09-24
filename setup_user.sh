mkdir .ssh
curl https://xn--schrder-d1a.xyz/public_keys >> ~/.ssh/authorized_keys
sudo chsh -s zsh steffen
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
