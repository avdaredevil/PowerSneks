function Host-Server {
    param(
        [String]$Server = 'localhost',
        [Int]$Port = '7777',
        [ScriptBlock]$OnData = {},
        [ScriptBlock]$OnChunk = {},
        [ScriptBlock]$OnDisconnect = {}
    )

    $tcpConnection = New-Object System.Net.Sockets.TcpClient($Server, $Port)
    $tcpStream = $tcpConnection.GetStream()
    $reader = New-Object System.IO.StreamReader($tcpStream)
    $writer = New-Object System.IO.StreamWriter($tcpStream)
    $writer.AutoFlush = $true

    while ($tcpConnection.Connected) {
        [String[]]$Chunk = @()
        while ($tcpStream.DataAvailable) {
            $Chunk += $data = $reader.ReadLine()
            $OnData.invoke($data)
        }
        $OnChunk.invoke($Chunk)
    }
    $OnDisconnect.invoke()

    $reader.Close()
    $writer.Close()
    $tcpConnection.Close()
}

function Client-Server {
    param (
        [String]$Server = 'localhost',
        [Int]$Port = '7777',
        [ScriptBlock]$OnData = {},
        [ScriptBlock]$OnChunk = {},
        [ScriptBlock]$OnDisconnect = {}
    )
    [System.Net.Sockets.TcpClient] $tcpClient = [System.Net.Sockets.TcpClient]::new("localhost", "50001")

    $tcpStream = $tcpClient.GetStream()
    [System.IO.StreamReader] $reader = [System.IO.StreamReader]::new($tcpStream)
    [System.IO.StreamWriter] $writer = [System.IO.StreamWriter]::new($tcpStream)
    $writer.AutoFlush = $true

    return [PSCustomObject]@{
        Listen = Value
    }
    while ($tcpClient.Connected) {
        [String[]]$Chunk = @()
        while ($tcpStream.DataAvailable) {
            $Chunk += $data = $reader.ReadLine()
            $OnData.invoke($data)
        }
        $OnChunk.invoke($Chunk)
    }
    $OnDisconnect.invoke()
    $reader.Close()
    $writer.Close()
    $tcpConnection.Close()
}
