param([switch] $Dev)

$CXX = "g++"
$CXXFlags = "--std=c++20"
$CXXFlagsDev = "-g"
$CXXFlagsRel = "-O3 -Wall -Wpedantic"

$sources = Get-ChildItem -Path src/ -Filter *.cpp

if(!(Test-Path -Path bin/)) {
    New-Item -Name "bin" -ItemType "directory" > $null
}

Clear-Host

if($Dev) {
    Write-Host "Running development build"
} else {
    Write-Host "Running release build"
    Remove-Item .\bin\*.exe
}

foreach($file in $sources ) {
    $name = $file.Name.Split(".")[0]
    if(![System.IO.File]::Exists(".\bin\$name.exe") -or $file.LastWriteTime -gt (Get-Item ".\bin\$name.exe").LastWriteTime) {
        $compileError = ""
        $error.Clear()
        Invoke-Expression "$CXX $CXXFlags $( $Dev ? $CXXFlagsDev : $CXXFlagsRel ) -o bin\$name.exe $file" -ErrorVariable compileError 2>$null
        if($error.Count -eq 0) {
            Write-Host "[C++]: src\$name.cpp => bin\$name.exe"
        } else {
            Write-Error "Error in $name.cpp"
            foreach($errorLine in $compileError) {
                Write-Host $errorLine
            }
            break
        }
    }
}