#####
# clone, fetch - remote branches
#####
git clone https://github.com/jagocki/git-samples.git
# crate git branch on server 
git config remote.origin.prune true
git pull
git branch -a -v 

# deleteing local branches deleted in the remote
# https://stackoverflow.com/questions/7726949/remove-tracking-branches-no-longer-on-remote
# Powershell
git checkout master; git remote update origin --prune; git branch -vv | Select-String -Pattern ": gone]" | % { $_.toString().Trim().Split(" ")[0]} | % {git branch -d $_}
# bash
git branch --merged | grep -v "\*" | grep -v "master" | grep -v "develop" | grep -v "staging" | xargs -n 1 git branch -d
# ??
git remote prune origin

#execute in linux shell 
while :; do clear; git log --graph --oneline --all --decorate ; sleep 1; done

git fetch

git fetch --prune

git config remote.origin.prune true

echo "test2" > Hello2.txt

git add Hello.txt

git commit -m "Hello commit"

git push


# something more tricky

#create an empty repo 
cd ..
mkdir remote-repo
cd remote-repo
git init --bare

#clone from local repo like it was a remote!
cd ..
git clone remote-repo local-repo
cd local-repo


#
