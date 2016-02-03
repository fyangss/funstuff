#turn on bash extblog
shopt -s extglob

#turn it off
shopt -u extglob

#delete everything except one file type with extglob on
rm -rf !(*.zip)

#'messy' way without extglob
find ~/foo/ -type f -not -name '*.zip' -delete

#regex sub for specific file type in a directory and change directory name
for i in $(\ls -d *.zip)
do
    mv $i $(echo $i | sed 's/(.*)/\1/')
done

#unzip to directory with same name
\ls ./*.zip | awk -F'.zip' '{print "unzip "$0" -d "$1}' | sh

#wget and save all dependencies
wget -r -l3 -k -p http://www.example.com

#change specific pattern in all files in a directory
find /path/to/dir -type f | grep 'pattern' | while read file; do sed -i 's/pattern_in_file/replacement/g' $file; done

#downloading java from oracle with appropraite license cookie
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u71-b15/jdk-8u71-linux-x64.rpm

