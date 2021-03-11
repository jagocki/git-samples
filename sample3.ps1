#bash script for monitoring the branches
#while :; do clear; git log --graph --oneline --all --decorate ; sleep 1; done


#update the file
echo "update2" > test2.txt
git diff HEAD test2.txt

# we have a problem with binary files (if you echoed from the Powershell, crating files from Linux shell it should be fine)
# follow https://stackoverflow.com/questions/777949/can-i-make-git-recognize-a-utf-16-file-as-text 
# for some remediation steps to make it work from command line
# excelent brief about Unicode encoding is here: https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses

git config --global diff.tool vimdiff 
git difftool HEAD test2.txt


git branch feature1
echo "master test3" > test3.txt
git checkout feature1

#the file is till modified, not added to the branch

git checkout master

git add test3.txt
git commit -m 'master test3'

git checkout feature1
echo "feature test3" > test3.txt
git add test3.txt
git commit -m 'feature test3'

git checkout master
git merge feature1

git diff
# merge changes in VS for example

#lets undo the merge!!!
git rev-parse master

#reposition current HEAD to particular commit
git reset --hard 5f14643
#atomic bomb solution to reset modified and delete new files
git clean -f

#show history for branch/commits changes 
git reflog

#to get back to merge commit - 

git checkout feature1
git rebase master
#resolve conflicts in VS

git checkout master
git merge feature1

git rebase -i HEAD~3





