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


## P12: Akses jarak jauh aman (SSH berbasis kunci + SCP)

Ringkasan: arsip hasil `bin/backup.sh` dikirim ke folder tujuan lewat SCP memakai kunci SSH (tanpa password), lalu diverifikasi dengan checksum SHA-256.

Cara pakai:

1. Buat arsip: `bash bin/backup.sh ~/dc ~/hb`
2. Kirim arsip dan checksum: `scp -i ~/.ssh/p12_key -o BatchMode=yes ~/hb/dc.tar.gz ~/hb/dc.tar.gz.sha256 localhost:~/p12-ssh/tujuan/`
3. Verifikasi di tujuan: `sha256sum -c dc.tar.gz.sha256`

Dokumen terkait:

- Contoh konfigurasi tanpa credential: `config/ssh.conf.example`
- Test case, analisis permission dan risiko: `docs/p12-test-case.md`
- Log uji diizinkan dan ditolak: `docs/p12-log.txt`
- Riwayat perubahan: `CHANGELOG.md`

Peringatan: private key dan isi `~/.ssh` tidak boleh di-commit atau ditampilkan.
