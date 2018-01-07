msg=$1
hugo -t cocoa-eh
echo "==your commit : $msg"
echo "==push to blog"
git add *
git commit -m msg
git push origin master
echo "==push to blog done"
echo "==push to public"
cd public
git add *
git commit -m msg
git push origin master
echo "==push to public done"
