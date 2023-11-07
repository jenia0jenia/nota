### install
```
sudo apt update
sudo apt install poppler-utils
sudo apt install imagemagick
sudo apt install musescore
sudo apt install unzip
sudo apt install git
```

### install java jdk 17
```
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb
dpkg -i jdk-17_linux-x64_bin.deb
```

### install Audiveris
```
git clone https://github.com/Audiveris/audiveris.git
cd audiveris
gradlew build
```

После этого можно запустить
```
sh start.sh
```