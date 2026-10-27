# Install the academic writing skills into every agent found on this machine.
#
#   irm https://raw.githubusercontent.com/ammelsayed/academic_writing_skills/main/install.ps1 | iex
#
# or, from a clone:
#
#   .\install.ps1              # install
#   .\install.ps1 -DryRun      # show what would happen
#   .\install.ps1 -Uninstall   # remove
[CmdletBinding()]
param(
    [switch]$DryRun,
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'
$Repo = 'https://github.com/ammelsayed/academic_writing_skills.git'

# Agent skill directories. Only agents whose parent directory exists are touched.
$Targets = @(
    @{ Label = 'Claude Code';               Dir = Join-Path $HOME '.claude\skills' },
    @{ Label = 'Codex';                     Dir = Join-Path $HOME '.codex\skills' },
    @{ Label = 'OpenCode';                  Dir = Join-Path $HOME '.config\opencode\skills' },
    @{ Label = 'Cursor';                    Dir = Join-Path $HOME '.cursor\skills' },
    @{ Label = 'zcode';                     Dir = Join-Path $HOME '.zcode\skills' },
    @{ Label = 'DSH';                       Dir = Join-Path $HOME '.dsh\skills' },
    @{ Label = 'WorkBuddy';                 Dir = Join-Path $HOME '.workbuddy\skills' },
    @{ Label = 'Agent Skills (universal)';  Dir = Join-Path $HOME '.agents\skills' }
)

$Skills = @('academic-paper', 'academic-literature-review', 'academic-paper-review')

# Resolve source: local clone if this script sits in one, else clone to temp.
$Local = Join-Path $PSScriptRoot 'skills\academic-paper\SKILL.md'
$Temp = $null
if (Test-Path $Local) {
    $Src = Join-Path $PSScriptRoot 'skills'
} else {
    $Temp = Join-Path ([System.IO.Path]::GetTempPath()) ("aws-" + [guid]::NewGuid().ToString('N'))
    Write-Host "Fetching skills from $Repo ..."
    git clone --depth 1 --quiet $Repo (Join-Path $Temp 'repo')
    $Src = Join-Path $Temp 'repo\skills'
}

function Invoke-Step {
    param([scriptblock]$Action, [string]$Description)
    if ($DryRun) { Write-Host "  [dry-run] $Description" }
    else { & $Action }
}

try {
    if ($Uninstall) {
        Write-Host 'Uninstalling academic writing skills'
        foreach ($t in $Targets) {
            foreach ($s in $Skills) {
                $path = Join-Path $t.Dir $s
                if (Test-Path $path) {
                    Invoke-Step { Remove-Item $path -Recurse -Force } "rm -rf $path"
                    Write-Host "  removed    $($t.Label)  $s"
                }
            }
        }
        return
    }

    $installed = 0
    foreach ($t in $Targets) {
        $parent = Split-Path $t.Dir -Parent
        if (-not (Test-Path $parent)) { continue }

        Invoke-Step { New-Item -ItemType Directory -Path $t.Dir -Force | Out-Null } "mkdir $($t.Dir)"
        foreach ($s in $Skills) {
            $dest = Join-Path $t.Dir $s
            Invoke-Step {
                if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
                Copy-Item (Join-Path $Src $s) $dest -Recurse -Force
            } "copy $s -> $dest"
            Write-Host "  installed  $($t.Label)  ->  $dest"
            $installed++
        }
    }

    if ($installed -eq 0) {
        Write-Host 'No supported agent found. Create one of these directories and re-run:'
        foreach ($t in $Targets) { Write-Host "  $($t.Dir)" }
        exit 1
    }

    Write-Host ''
    Write-Host "Done. $installed skill installs. Restart the agent, or run its reload command."
}
finally {
    if ($Temp -and (Test-Path $Temp)) { Remove-Item $Temp -Recurse -Force -ErrorAction SilentlyContinue }
}
