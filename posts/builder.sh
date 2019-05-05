#!/bin/bash
i=1
for dir in orig/*
do
    #read in post info
    read -r header < "$dir/header"
    read -r content < "$dir/content"
    read -r title < "$dir/title"
    filename=$(basename $dir) #get filename for making buttons and saving most recent post

    #build html files with sed
    sed -e "s/#header/$header/" -e "s/#content/$content/" -e "s/#title/$title/" ../templates/fuck.html > html/$filename.html
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
