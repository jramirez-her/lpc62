#Joaquin Ramirez Hernandez 1860939
$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "Tu gateway: $subred"

#Rango de subred
$rango = $subred.Substring(0, $subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 4)
echo $rango

#DEterminar si rango termina en punto
$punto = $rango.EndsWith(".")
if ($punto -like "False"){
    $rango = $rango + "."
}

$rango_ip = @(1..254)

foreach($r in $rango_ip){
    $actual = $rango + $r 
    $responde= Test-Connection $actual -Quiet -Count 1
    if($responde -eq "True"){
        Write-Output ""
        Write-Host "Host responde: " -NoNewLine; Write-Host $actual -ForegroundColor Green
    }
}