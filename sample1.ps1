#####
# clone, fetch - remote branches
#####
git clone https://github.com/jagocki/git-samples.git
# crate git branch on server 
git config remote.origin.prune true
git pull
git branch -a -v 

#execute in linux shell 
while :; do clear; git log --graph --oneline --all --decorate ; sleep 1; done

git fetch

git fetch --prune

git config remote.origin.prune true

echo "test" > Hello.txt

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
