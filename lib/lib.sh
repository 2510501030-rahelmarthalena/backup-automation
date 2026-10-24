log(){ mkdir -p "$(dirname "$LOG")"; echo "$(date '+%F %T') [$1] $2" | tee -a "$LOG"; }
cek(){
[ -n "$S" ] && [ -n "$D" ] || { log ERROR "argumen kurang"; exit 2; }
[ -d "$S" ] && [ "$S" != "/" ] || { log ERROR "sumber salah: $S"; exit 3; }
mkdir -p "$D" && [ -w "$D" ] || { log ERROR "tujuan gagal: $D"; exit 4; }
}
