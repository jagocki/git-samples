#https://www.youtube.com/watch?v=52MFjdGH20o


mkdir .git
mkdir .git/objects
mkdir .git\objects
mkdir .git\refs
mkdir .git\refs\heads
echo ref: refs/heads/master > .git\HEAD
git status
echo Brief channel is awesome | git hash-object --stdin -w
git cat-file -p 12afd3090092069b609372f6d279a82ce574bdae
git update-index --add --cacheinfo 10644 12afd3090092069b609372f6d279a82ce574bdae brief.txt

# On branch master

# No commits yet

# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#         new file:   brief.txt

# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git restore <file>..." to discard changes in working directory)
        # deleted:    brief.txt
git cat-file -p 12afd3090092069b609372f6d279a82ce574bdae > brief.txt

git write-tree
#f0f60b298e11aa5e6a2a927d65284de5b2866f60
# tree
# Folder PATH listing
# Volume serial number is 900F-0243
# C:.
# └───.git
#     ├───objects
#     │   ├───12
#     │   └───f0
#     └───refs
#         └───heads

git commit-tree f0f60b298e11aa5e6a2a927d65284de5b2866f60 -m "Initial commit"
d8dccf4657a058245cb42425e7c98cff3c75ed19

git cat-file -t d8dccf4657a058245cb42425e7c98cff3c75ed19

git cat-file -p d8dccf4657a058245cb42425e7c98cff3c75ed19
# tree f0f60b298e11aa5e6a2a927d65284de5b2866f60
# author mail-addr 1615479170 +0100
# committer mail-addr 1615479170 +0100

# Initial commit

echo d8dccf4657a058245cb42425e7c98cff3c75ed19 > .git\refs\heads\master
git status
# On branch master
# nothing to commit, working tree clean
echo d8dccf4657a058245cb42425e7c98cff3c75ed19 > .git\refs\heads\test
#swtich branches
echo ref: refs/heads/test > .git\HEAD