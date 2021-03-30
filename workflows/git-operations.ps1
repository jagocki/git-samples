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
    
    function MergeFeature{
        param($branchFolderName, $branchName, $commitPrefix)
        git checkout develop
        $newBranchName = "$branchFolderName" + '/' + "$branchName"
        git merge $newBranchName --no-ff
    }
    
    function DevelopOnBranch {
        param($branchFolderName, $branchName, $commitPrefix)
        $newBranchName = "$branchFolderName" + '/' + "$branchName"
        git branch $newBranchName
        CreateLocalChanges $newBranchName $commitPrefix 2
        
    }
    
    
    function WorkOnFeature{
    param (
        $featureName
    )
        git checkout develop
        DevelopOnBranch 'feature' $featureName 'development'
    }
    
    function FinishFeature {
        param (
            $featureName
        )
        MergeFeature 'feature' $featureName 'development'
    }
    
    
    function CreateRelease {
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
    
    $global:stack = New-Object System.Collections.Stack