Write-Host "Starting Installation of Apps"
$apps = @( 
    @{name = "Microsoft.PowerShell" },
    @{name = "Microsoft.VisualStudioCode" }, 
    @{name = "Microsoft.VisualStudio.2022.Community" }, 
    @{name = "Microsoft.WindowsTerminal"; source = "msstore" },
    @{name = "JanDeDobbeleer.OhMyPosh"; source = "winget" }, 
    @{name = "Microsoft.AzureStorageExplorer" }, 
    @{name = "Microsoft.PowerToys" }, 
    @{name = "JetBrains.Toolbox" }, 
    @{name = "Git.Git" }, 
    @{name = "Docker.DockerDesktop" },
    @{name = "Microsoft.dotnet" },
    @{name = "anki.anki" },
    @{name = "9P8LTPGCBZXD" },
    @{name = "Notion.Notion" },
    @{name = "th-ch.YouTubeMusic" },
    @{name = "GitHub.GitHubDesktop.Beta" },
    @{name = "GitHub.cli" }
);
Foreach ($app in $apps) {
    #check if the app is already installed
    $listApp = winget list --exact -q $app.name --accept-source-agreements
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing:" $app.name
        if ($app.source -ne $null) {
            winget install --exact --accept-source-agreements --silent $app.name --source $app.source
        }
        else {
            winget install --exact --accept-source-agreements --silent $app.name 
        }
    }
    else {
        Write-host "Skipping Install of " $app.name
    }
}
