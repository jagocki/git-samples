####
## stash
####
echo "test1" > test1.txt
git stash save -u "test1"
git stash list

#git stash pop
git stash list
#another change
echo "test2" > test2.txt
git stash save -u "test2"

git stash list
git stash apply 1
git stash pop 0

git stash list

git reset $commitID

git reset HEAD^
git reset HEAD^^^

git revert $commitID

git reflog

git reset --hard 'HEAD@{15}'

