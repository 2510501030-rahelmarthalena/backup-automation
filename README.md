# Backup Otomatis

- **Use case:** backup direktori ke tar.gz + checksum SHA-256 + log
- **Tujuan:** mengurangi kesalahan backup manual dan beri jejak audit
- **Jalankan:** `bash bin/backup.sh SUMBER TUJUAN`
- **Test:** `bash tests/run_tests.sh` (T1 sukses; T2, T3, T4 gagal)
- **Verifikasi:** `sha256sum -c TUJUAN/NAMA.tar.gz.sha256` dan `cat logs/backup.log`
- **Cleanup:** `rm -rf TUJUAN logs/backup.log`
- **Rollback:** `tar -xzf TUJUAN/NAMA.tar.gz -C /tmp/restore`
- **Exit status:** 0 sukses, 2 argumen, 3 sumber, 4 tujuan, 5 arsip
- **Config contoh:** `config/backup.conf.example`
- **Lanjutan:** cron dan container (P12-P15)
