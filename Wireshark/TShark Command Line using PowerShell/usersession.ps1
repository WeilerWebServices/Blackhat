# Sessions for user
param (
 $file, $user
)

$userFilter = "http.request and http contains `"$user`""
$cookies = tshark -r "$file" -Y $userFilter -T fields -e "http.cookie" |
         ForEach-Object { $_.split("=")[2] }

foreach ($cookie in $cookies) {
 $tmpFile = "tmp_$cookie.pcapng"
 $cookieFilter = "http.request and http.cookie contains `"$cookie`""
 $portFilter = (tshark -r $file -Y $cookieFilter -T fields -e "tcp.stream" |
        ForEach-Object { "tcp.stream == {0}" -f $_ }) -join " or "
 tshark -r $file -w $tmpFile -Y $portFilter
}

mergecap -w "$user.pcapng" "tmp_*.pcapng"
Remove-Item tmp_*.pcapng
