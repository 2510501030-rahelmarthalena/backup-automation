LOG=logs/backup.log
. lib/lib.sh
S=$1; D=$2
cek
F=$D/$(basename $S).tar.gz
tar -czf $F $S 2>/dev/null || { log ERROR "tar gagal"; exit 5; }
sha256sum $F > $F.sha256 && log INFO "sukses: $F"
