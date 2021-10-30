$files = Get-ChildItem -Path .\ -Filter *.blend -Recurse -ErrorAction SilentlyContinue -Force

ForEach ($file in $files) {
    
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $stringBuilder = New-Object Text.StringBuilder
    for ($i = 0; $i -lt 7; $i++){
        [void]$stringBuilder.Append([char]$bytes[$i])
    }

    if ($stringBuilder.ToString() -eq "BLENDER"){
        $target = "$($file.FullName).gzip"
        & 7z a $target $file.FullName
        Remove-Item $file.FullName
        Move-Item $target $file.FullName
    }     
}

#7.86GB -> 5.19GB
#28GB
