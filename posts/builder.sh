#!/bin/bash
i=1
b=1
for dir in orig/*
do
    #read in post info
    read -r header < "$dir/header"
    read -r content < "$dir/content"
    read -r title < "$dir/title"
    filename=$(basename $dir) #get filename for making buttons and saving most recent post

    #build html files with sed
    sed -e "s/#header/$header/" -e "s/#content/$content/" -e "s/#title/$title/" ../templates/generic.html > html/$filename.html
    html=$(cat html/$filename.html)
    if [ ! -z $(ls $dir/*.png 2>/dev/null) ]
            echo fuck
    then
        for image in $dir/*.png
        do
            image=${image//\//\\\/}
            echo $image
            html="$(printf "$html" | sed -e '0,/<!--/s///' -e '0,/-->/s///' -e "0,/#image/s//<img src=\"..\/posts\/$image\" class=\"image$b\"\/>/" )"
            echo fuckks
            echo "$html" > html/$filename.html
            b=$((b+1))
        done
    fi

    pagebutton="<button onclick=\"window.location.href = '$filename.html'\" class=\"pagebutton$i\">$header<\/button>"
    pages="$pages\n$pagebutton"
    #cycle i for rainbow color alternation on posts list
    i=$((i+1))
    [ $i = 7 ] && i=1
done

#build posts list
sed -e "s/#posts/$pages/g" ../templates/posts.html > ../pages/posts.html

#copy out built html files
cp html/* ../pages/
cp "html/$filename.html" ../pages/fuck.html 
sed -e 's/\.\.\///g' "html/$filename.html" > ../index.html #for index.html substitute .. paths

#get git commit info and commit post
git add -A
echo post info
read commitmessage
git commit -m "$commitmessage"
git push
