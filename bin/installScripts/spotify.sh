# 1. Add this line to your list of repositories by
#    editing your /etc/apt/sources.list
sudo sh -c 'echo deb http://repository.spotify.com testing non-free > /etc/apt/sources.list.d/spotify.list'

# 2. If you want to verify the downloaded packages,
#    you will need to add our public key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59

# 3. Run apt-get update
sudo apt-get update

# 4. Install spotify!
sudo apt-get install spotify-client
