param($saveto)

Get-Clipboard -Format Image -OutVariable x
$x.save($saveto)