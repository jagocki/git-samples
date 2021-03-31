. .\git-operations.ps1

$targetDir = 'git-flow-test'
Remove-Item -Recurse -Force $targetDir
InitRepo $targetDir 

git branch develop
WorkOnFeature f1 develop
WorkOnFeature f2 develop
WorkOnFeature f2 develop
FinishFeatureNoFF f1 develop
CreateReleaseGitFlow 'rel1'
WorkOnFeature f2  develop
FinishFeatureNoFF f2  develop
CreateReleaseGitFlow 'rel2'
cd ..
# git log --all --oneline --graph --decorate --color --branches
OpenRepoBrowser $targetDir
    