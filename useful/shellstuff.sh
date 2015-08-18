#turn on bash extblog
shopt -s extglob

#turn it off
shopt -u extglob

#delete everything except one file type with extglob on
rm -rf !(*.zip)

#'messy' way without extglob
find ~/foo/ -type f -not -name '*.zip' -delete

#regex sub filename pattern
for i in $(\ls -d *.zip)
do
    mv $i $(echo $i | sed 's/(.*)/\1/')
done

#unzip to directory with same name
\ls ./*.zip | awk -F'.zip' '{print "unzip "$0" -d "$1}' | sh
