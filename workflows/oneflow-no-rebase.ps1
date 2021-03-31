# implementing workflow described here
# https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow#oneflow-advantages
. .\git-operations.ps1


$targetDir = 'one-flow-no-rebase'
Remove-Item -Recurse -Force $targetDir

InitRepo $targetDir 

WorkOnFeature f1 master
WorkOnFeature f2 master
WorkOnFeature f2 master
FinishFeatureNoFF f1 master
CreateReleaseOneFlow 'rel1'
WorkOnFeature f2  master
FinishFeatureNoFF f2  master
CreateReleaseOneFlow 'rel2'

#git log --all --oneline --graph --decorate --color --branches
cd ..
OpenRepoBrowser $targetDir
