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
git commit -m "$commitPrefix on $branchName $val"
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

function MergeFeatureNoFF{
    param($branchFolderName, $branchName, $commitPrefix, $baseBranchName)
    git checkout $baseBranchName
    $newBranchName = "$branchFolderName" + '/' + "$branchName"
    git merge $newBranchName --no-ff
}

function MergeFeatureWithRebase{
    param($branchFolderName, $branchName, $commitPrefix, $baseBranchName, $ffOperation)
    $newBranchName = "$branchFolderName" + '/' + "$branchName"
    git checkout $newBranchName
    git rebase $baseBranchName
    git checkout $baseBranchName
    git merge $ffOperation $newBranchName 
}

function DevelopOnBranch {
    param($branchFolderName, $branchName, $commitPrefix)
    $newBranchName = "$branchFolderName" + '/' + "$branchName"
    git branch $newBranchName
    CreateLocalChanges $newBranchName $commitPrefix 2
    
}


function WorkOnFeature{
param (
    $featureName, $baseBranchName
)
    git checkout $baseBranchName
    DevelopOnBranch 'feature' $featureName 'development'
}

function FinishFeatureNoFF {
    param (
        $featureName, $baseBranchName
    )
    MergeFeatureNoFF 'feature' $featureName 'development' $baseBranchName
}

function FinishFeatureWithRebase {
    param (
        $featureName, $baseBranchName
    )
    MergeFeatureWithRebase 'feature' $featureName 'development' $baseBranchName '--ff-only'
}

function FinishFeatureWithRebaseNoFF {
    param (
        $featureName, $baseBranchName
    )
    MergeFeatureWithRebase 'feature' $featureName 'development' $baseBranchName '--no-ff'
}

function CreateReleaseGitFlow {
    param (
        $releaseName
    )
    DevelopOnBranch 'release' $releaseName 'stabilization'
    git checkout develop 
    git merge "release/$releaseName" --no-ff
    git checkout master 
    git merge "release/$releaseName" --no-ff
    git tag $releaseName
}

function CreateReleaseOneFlow {
    param (
        $releaseName
    )
    DevelopOnBranch 'release' $releaseName 'stabilization'
    git tag $releaseName
    git checkout master
    git merge "release/$releaseName" 
}


function InitRepo {
    param ( 
    $targetDir
    )
    mkdir $targetDir
    cd $targetDir
    git init
    CreateCommit 'master' 'init'
}

function OpenRepoBrowser {
    param (
        $repoDirName
    )
    $repopath = get-location | % { $_.Path}
    $repopath +=  '\' + $repoDirName
    & "C:\Program Files (x86)\GitExtensions\GitExtensions.exe" openrepo  $repopath
}

$global:stack = New-Object System.Collections.Stack