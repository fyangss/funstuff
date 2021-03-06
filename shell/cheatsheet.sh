# turn on bash extblog
shopt -s extglob

# delete everything except one file type with extglob on
rm -rf !(*.zip)

# turn it off
shopt -u extglob

# 'messy' way without extglob
find ~/foo/ -type f -not -name '*.zip' -delete

# regex sub for specific file type in a directory and change directory name
for i in $(\ls -d *.zip)
do
    mv $i $(echo $i | sed 's/(.*)/\1/')
done

# unzip to directory with same name
\ls ./*.zip | awk -F'.zip' '{print "unzip "$0" -d "$1}' | sh

# wget and save all dependencies
wget -r -l3 -k -p http://www.example.com

# change specific pattern in all files in a directory
find /path/to/dir -type f | grep 'pattern' | while read file; do sed -i 's/pattern_in_file/replacement/g' $file; done

# downloading java from oracle with appropraite license cookie
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u71-b15/jdk-8u71-linux-x64.rpm

# git log with tree and stuff
git log --graph --decorate --all --pretty=short
# two line
git log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)"%an" <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order

# git in multiple git dirs
find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull --rebase \;

# new branch alias
alias upstream='function _upstream() { git checkout -b $1 && git branch --set-upstream-to=$2 }; _upstream'

# one liner for loop syntax
for i in {1..10}; do echo $i; done

# one liner while loop syntax
let i=0; while [ $i -lt 5 ]; do echo $(( i++ )); done

# read file line by line
while read f; echo $f; done < ${file_path}

# negative matching
grep -v

# grep, edit, and save
ls | grep '^s' | sed 's/.*pattern: "\(abc\)".*/`sh \1 2>\&1 \&'/g' >> file
