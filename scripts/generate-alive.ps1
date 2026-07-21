$birth = [DateTimeOffset]::Parse("2026-07-20T18:30:00+08:00")
$now = [DateTimeOffset]::Now
$totalSec = [Math]::Max(0, [int][Math]::Floor(($now - $birth).TotalSeconds))
$days = [int][Math]::Floor($totalSec / 86400.0)
$hours = [int][Math]::Floor(($totalSec % 86400) / 3600.0)
$minutes = [int][Math]::Floor(($totalSec % 3600) / 60.0)
$seconds = [int]($totalSec % 60)
$h = $hours.ToString("00")
$m = $minutes.ToString("00")
$s = $seconds.ToString("00")

Write-Host ("Age: {0}d {1}:{2}:{3} (totalSec={4})" -f $days, $h, $m, $s, $totalSec)

$template = @'
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="640" height="160" viewBox="0 0 640 160" role="img">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#FFF7ED"/>
      <stop offset="100%" stop-color="#FFEDD5"/>
    </linearGradient>
  </defs>
  <rect width="640" height="160" rx="20" fill="url(#bg)" stroke="#FDBA74" stroke-width="2"/>
  <text x="32" y="38" font-family="Segoe UI, system-ui, sans-serif" font-size="18" fill="#9A3412" font-weight="600">猫猫鸡已存活</text>
  <text x="32" y="62" font-family="Segoe UI, system-ui, sans-serif" font-size="12" fill="#C2410C">出生于 2026-07-20 18:30:00（北京时间）· 约每 5 分钟自动刷新</text>
  <g font-family="ui-monospace, Cascadia Code, Consolas, monospace" font-weight="700">
    <g transform="translate(32,78)">
      <rect width="120" height="64" rx="12" fill="#FFFFFF" stroke="#FDBA74"/>
      <text x="60" y="38" text-anchor="middle" font-size="30" fill="#EA580C">__DAYS__</text>
      <text x="60" y="54" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif" font-size="12" font-weight="600" fill="#9A3412">天</text>
    </g>
    <g transform="translate(168,78)">
      <rect width="100" height="64" rx="12" fill="#FFFFFF" stroke="#FDBA74"/>
      <text x="50" y="38" text-anchor="middle" font-size="30" fill="#EA580C">__H__</text>
      <text x="50" y="54" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif" font-size="12" font-weight="600" fill="#9A3412">时</text>
    </g>
    <g transform="translate(284,78)">
      <rect width="100" height="64" rx="12" fill="#FFFFFF" stroke="#FDBA74"/>
      <text x="50" y="38" text-anchor="middle" font-size="30" fill="#EA580C">__M__</text>
      <text x="50" y="54" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif" font-size="12" font-weight="600" fill="#9A3412">分</text>
    </g>
    <g transform="translate(400,78)">
      <rect width="100" height="64" rx="12" fill="#FFFFFF" stroke="#FDBA74"/>
      <text x="50" y="38" text-anchor="middle" font-size="30" fill="#EA580C">__S__</text>
      <text x="50" y="54" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif" font-size="12" font-weight="600" fill="#9A3412">秒</text>
    </g>
  </g>
</svg>
'@

$svg = $template.Replace("__DAYS__", "$days").Replace("__H__", $h).Replace("__M__", $m).Replace("__S__", $s)
$out = Join-Path $PSScriptRoot "..\assets\alive.svg"
[System.IO.File]::WriteAllText($out, $svg, [System.Text.UTF8Encoding]::new($false))
Write-Host "Wrote $out"
