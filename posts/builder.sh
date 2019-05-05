#!/bin/bash
i=1
for dir in orig/*
do
    read -r header < "$dir/header"
    read -r content < "$dir/content"
    read -r title < "$dir/title"
    filename=$(basename $dir)
    sed -e "s/#header/$header/" -e "s/#content/$content/" -e "s/#title/$title/" ../templates/fuck.html > html/$filename.html
    pagebutton="<button onclick=\"window.location.href = '$filename.html'\" class=\"pagebutton$i\">$header<\/button>"
    pages="$pages\n$pagebutton"
    i=$((i+1))
    [ $i = 7 ] && i=1
done
sed -e "s/#posts/$pages/g" ../templates/posts.html > ../pages/posts.html
cp html/* ../pages/
git add -A
cp "html/$filename.html" ../pages/fuck.html 
sed -e 's/\.\.\///g' "html/$filename.html" > ../index.html
echo post info
read commitmessage
git commit -m "$commitmessage"
git push
