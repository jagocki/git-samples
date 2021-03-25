
function RandomString{
param($length=4)
   return -join ((65..90) + (97..122) | Get-Random -Count $length | % {[char]$_})
}

function CheckoutBranch{
    param($branch)
    $current = &git rev-parse --abbrev-ref HEAD 
    $global:stack.Push($current)
    git checkout $branch
}

function PopBranch {
    $branchname = $global:stack.Pop()
    git checkout $branchname
}

function CreateCommit{
param($branchName, $commitPrefix)
CheckoutBranch $branchName
$val = RandomString
echo $val > "$val.txt"
git add "$val.txt"
git commit -m "$commitPrefix $val"
PopBranch
}

function CreateLocalChanges {
    param (
        $branchName, $commitPrefix, $numOfCommits
    )
    for ($i = 0; $i -lt $numOfCommits; $i++) {
        CreateCommit $branchName $commitPrefix
    }
}

function BranchCommitMerge{
    param($branchFolderName, $branchName, $commitPrefix)
    $newBranchName = "$branchFolderName" + '/' + "$branchName"
    git checkout develop
    git branch $newBranchName
    CreateLocalChanges $newBranchName $commitPrefix 4
    git merge $newBranchName --no-ff
}

function CreateFeature {
    param (
        $featureName
    )
    BranchCommitMerge 'feature' $featureName 'development'
}


function CreateRelease {
    param (
        $releaseName
    )
    BranchCommitMerge 'release' $releaseName 'stabilization'
}

$global:stack = New-Object System.Collections.Stack

mkdir gitflow-repo
cd gitflow-repo
git init
CreateCommit 'master' 'init'
git branch develop

CreateFeature f1
CreateFeature f1

CreateRelease 'rel1'

git log --all --oneline --graph