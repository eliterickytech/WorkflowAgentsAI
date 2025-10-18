#Requires -Version 5.1
<#
.SYNOPSIS
  Lists Azure DevOps Git repositories for a given organization and project.

.DESCRIPTION
  Prompts securely for a PAT (or uses $env:ADO_PAT if set) and queries the ADO REST API.
  Filters by repository name containing the provided text (case-insensitive).

.PARAMETER Org
  Azure DevOps organization (e.g., totvstfs)

.PARAMETER Project
  Azure DevOps project (e.g., HR-PeopleBudget)

.PARAMETER NameFilter
  Substring to filter repository names (case-insensitive). Default: hr-peoplebudget

.EXAMPLE
  powershell -NoProfile -ExecutionPolicy Bypass -File scripts/powershell/ado-list-repos.ps1 -Org totvstfs -Project HR-PeopleBudget -NameFilter hr-peoplebudget

.NOTES
  - Does not persist your PAT; uses in-memory only.
  - API: GET https://dev.azure.com/{org}/{project}/_apis/git/repositories?api-version=7.1-preview.1
#>

param(
    [Parameter(Mandatory = $false)] [string] $Org = "totvstfs",
    [Parameter(Mandatory = $false)] [string] $Project = "HR-PeopleBudget",
    [Parameter(Mandatory = $false)] [string] $NameFilter = "hr-peoplebudget"
)

$ErrorActionPreference = 'Stop'

function Get-BasicAuthHeader {
    param([Parameter(Mandatory = $true)][string] $Pat)
    $bytes = [Text.Encoding]::ASCII.GetBytes("user:$Pat")
    $base64 = [Convert]::ToBase64String($bytes)
    return @{ Authorization = "Basic $base64" }
}

try {
    # Acquire PAT securely
    $plainPat = $null
    if ([string]::IsNullOrWhiteSpace($env:ADO_PAT)) {
        $securePat = Read-Host -AsSecureString "Azure DevOps PAT"
        $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePat)
        try { $plainPat = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr) } finally {
            if ($bstr -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr) }
        }
    } else {
        $plainPat = $env:ADO_PAT
    }

    if ([string]::IsNullOrWhiteSpace($plainPat)) {
        throw "PAT not provided. Set ADO_PAT env var or enter it at the prompt."
    }

    $headers = Get-BasicAuthHeader -Pat $plainPat
    $url = "https://dev.azure.com/$Org/$Project/_apis/git/repositories?api-version=7.1-preview.1"

    Write-Host "Querying repos from $Org/$Project ..." -ForegroundColor Cyan
    $res = Invoke-RestMethod -Method GET -Uri $url -Headers $headers

    $regex = [Regex]::Escape($NameFilter)
    $repos = $res.value |
        Where-Object { $_.name -match $regex } |
        Select-Object @{n='name';e={$_.name}}, @{n='id';e={$_.id}}, @{n='webUrl';e={$_.webUrl}} |
        Sort-Object name

    if (-not $repos -or $repos.Count -eq 0) {
        Write-Host "No repositories matched filter '$NameFilter' in project '$Project'." -ForegroundColor Yellow
        return
    }

    $repos | Format-Table -AutoSize
}
catch {
    Write-Error $_
    exit 1
}
