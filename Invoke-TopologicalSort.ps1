function Invoke-TopologicalSort {
    param (
        [Parameter(Mandatory)]
        [hashtable]$Graph,
        [switch]$Reverse
    )

    # 各ノードの入力次数を保存するハッシュテーブルを初期化
    $inDegree = @{}
    foreach ($node in $Graph.Keys) {
        $inDegree[$node] = 0
    }

    # 各ノードの入力次数を計算
    foreach ($node in $Graph.Keys) {
        foreach ($neighbor in $Graph[$node]) {
            $inDegree[$neighbor]++
        }
    }

    # 入力次数が0のノードをキューに追加
    $queue = [System.Collections.Queue]::new()
    foreach ($node in $inDegree.Keys) {
        if ($inDegree[$node] -eq 0) {
            $queue.Enqueue($node)
        }
    }

    $sortedList = @()

    # キューが空になるまで続ける
    while ($queue.Count -gt 0) {
        $node = $queue.Dequeue()
        $sortedList += $node

        # 隣接ノードの入力次数を減らし、入力次数が0になったらキューに追加
        foreach ($neighbor in $Graph[$node]) {
            $inDegree[$neighbor]--
            if ($inDegree[$neighbor] -eq 0) {
                $queue.Enqueue($neighbor)
            }
        }
    }

    # ソートされたリストの長さがグラフのノード数と一致しない場合、グラフにはサイクルが存在する
    if ($sortedList.Count -ne $Graph.Count) {
        Throw("The graph has a cycle involving the node and cannot be topologically sorted.")
    }

    if ($Reverse) {
        [array]::Reverse($sortedList)
    }
    return $sortedList
}

# Example
$Graph = @{
    'A' = @('E')
    'B' = @('A')
    'C' = @()
    'D' = @('B', 'C')
    'E' = @()
    'F' = @()
}

try {
    $sortedOrder = Invoke-TopologicalSort -graph $Graph
    Write-Host "Topologically sorted order: $sortedOrder"
}
catch {
    Write-Error $_.Exception.Message
}