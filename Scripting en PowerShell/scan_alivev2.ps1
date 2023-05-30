#Joaquin Ramirez Hernandez 1860939
$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-host "== Determinando tu gateway..."
Write-Host "Tu gateway: $subred"

#Rango de subred
$rango = $subred.Substring(0, $subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 4)
Write-host "== Determinando el rango de tu subred..."
echo $rango

#DEterminar si rango termina en punto
$punto = $rango.EndsWith(".")
if ($punto -like "False"){
    $rango = $rango + "."
}

$rango_ip = @(1..254)

Write-Output ""
Write-Host "-- Subred actual: "
Write-Host "Escaneando: " -NoNewline ; Write-Host $rango -NoNewline; Write-Host "0/24" -ForegroundColor Red
Write-Output ""
foreach($r in $rango_ip){
    $actual = $rango + $r 
    $responde= Test-Connection $actual -Quiet -Count 1
    if($responde -eq "True"){
        Write-Output ""
        Write-Host "Host responde: " -NoNewLine; Write-Host $actual -ForegroundColor Green
    }
}