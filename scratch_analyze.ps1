$repos = Get-Content -Raw "repos.json" | ConvertFrom-Json

Write-Output "TOTAL DE REPOSITORIOS: $($repos.Count)"

Write-Output "`n=== LINGUAGENS UTILIZADAS ==="
$repos | Group-Object language | Sort-Object Count -Descending | ForEach-Object {
    $lang = if ($_.Name) { $_.Name } else { "Sem linguagem definida / Outro" }
    Write-Output "- ${lang}: $($_.Count) repositórios"
}

Write-Output "`n=== REPOSITÓRIOS PRÓPRIOS (NÃO-FORK) ==="
$ownRepos = $repos | Where-Object { -not $_.fork }
Write-Output "Total próprios: $($ownRepos.Count)"

$ownRepos | Sort-Object stargazers_count, updated_at -Descending | ForEach-Object {
    Write-Output "--------------------------------------------------"
    Write-Output "Nome: $($_.name)"
    Write-Output "URL: $($_.html_url)"
    Write-Output "Linguagem: $($_.language)"
    Write-Output "Stars: $($_.stargazers_count) | Forks: $($_.forks_count)"
    Write-Output "Homepage: $($_.homepage)"
    Write-Output "Descrição: $($_.description)"
    Write-Output "Tópicos: $($_.topics -join ', ')"
    Write-Output "Criado: $($_.created_at) | Atualizado: $($_.updated_at)"
}
