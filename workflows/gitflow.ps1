. git-operations.ps1

$targetDir = 'gitlap-test'
mkdir $targetDir
cd $targetDir
git init
CreateCommit 'master' 'init'
git branch develop

WorkOnFeature f1
WorkOnFeature f2
WorkOnFeature f2
FinishFeature f1
FinishFeature f1
FinishFeature f1
CreateRelease 'rel1'
WorkOnFeature f2
FinishFeature f2
CreateRelease 'rel2'

git log --all --oneline --graph --decorate --color --branches
    