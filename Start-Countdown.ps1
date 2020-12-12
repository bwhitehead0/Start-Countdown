function Start-Countdown {
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Duration,
        [Parameter(Mandatory = $false)]
        [switch]$UserInteraction,
        [Parameter(Mandatory = $false)]
        [string]$Label = "Countdown for $Duration seconds..."
    )

    $EndTime = [datetime]::UtcNow.AddSeconds($Duration)

    while (($TimeRemaining = ($EndTime - [datetime]::UtcNow)) -gt 0) {
        Write-Progress -Activity "Waiting..." -Status $Label -SecondsRemaining $TimeRemaining.TotalSeconds
        Start-Sleep 1
    }

    if ( $UserInteraction ) {
        Write-Host -NoNewline "Press any key to continue..."
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        Write-Host ""
        Write-Host "Continuing..."
    }
}