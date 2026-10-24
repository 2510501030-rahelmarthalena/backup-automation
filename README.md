#Backup Otomatis
Use case: backup direktori ke tar.gz + checksum SHA-256 +log.
Tujuan: mengurangi kesalahan backup manual dan beri jejak audit.
Jalankan: bash bin/backup.sh SUMBER TUJUAN
Test: bash tests/run_tests.sh (T1 sukses; T2, T3, T4 gagal)
Verifikasi: sha256sum -c TUJUAN/NAMA.tar.gz.sha256 ; cat logs/backup/log
