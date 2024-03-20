## Что делает
Из pdf файлов с изображениями нот получает звуковые mid(`.mid`) файлы и musicxml(`.mxl, .xml`)

## Как делает
1. Из pdf в png
2. Из png в pdf (Иначе не разпознает, [https://github.com/Audiveris/audiveris/issues/280](https://github.com/Audiveris/audiveris/issues/280))
3. Из pdf в mxl (сжатый musicxml)
4. Из mxl в xml (разжатый musicxml)
5. Из xml в mid (звуковой файл)

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

## Использование скрипта `start.sh`

### Без аргументов
```
sh start.sh
```
Скрипт, запущенный без аргументов берёт все `*.pdf` файлы в папке `nota`, пропускает те, у которые есть соответствующие `.mid` файлы

### С аргументами
```
sh start.sh n0002289.pdf
```
Скрипт, запущенный с названиями pdf-файлов берёт их в папке `nota`, пропускает те, у которые есть соответствующие `.mid` файлы