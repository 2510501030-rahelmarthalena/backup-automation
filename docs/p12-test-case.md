# Test case P12: SSH berbasis kunci + SCP

| Kode | Skenario | Command (ringkas) | Hasil diharapkan | Hasil aktual |
|---|---|---|---|---|
| TP1 | Login kunci sah | ssh -i ~/.ssh/p12_key -o BatchMode=yes localhost 'echo akses-ok' | akses-ok, exit 0 | sesuai |
| TP2 | Kirim arsip backup | bash bin/backup.sh ~/dc ~/hb, lalu scp dc.tar.gz dan dc.tar.gz.sha256 ke folder tujuan | exit 0, checksum OK | sesuai |
| TN1 | Kunci tidak terdaftar | ssh -i kunci_palsu -o IdentitiesOnly=yes -o BatchMode=yes localhost | Permission denied, exit 255 | sesuai |
| TN2 | User tidak ada | ssh -i ~/.ssh/p12_key -o BatchMode=yes tamu@localhost | Permission denied, exit 255 | sesuai |
| TN3 | SCP dengan kunci palsu | scp -i kunci_palsu ... palsu.tar.gz | Permission denied, exit 255, file tidak masuk | sesuai |

## Analisis permission
- ~/.ssh = 700 (drwx------), authorized_keys dan kunci privat = 600, kunci publik = 644.
- Permission yang terlalu longgar membuat SSH menolak kunci privat.

## Analisis risiko
- Server masih menerima password (publickey,password), jadi rentan tebak password. Rekomendasi: PasswordAuthentication no (butuh sudo, hanya direkomendasikan).
- Kunci tanpa passphrase praktis untuk otomasi, tapi kalau bocor langsung bisa dipakai. Rekomendasi: passphrase atau ssh-agent.
- Pengujian ke localhost belum mewakili jaringan nyata.

## Cleanup dan rollback
- Hapus kunci uji dan arsip di folder tujuan dengan path eksplisit.
- Kosongkan authorized_keys ke kondisi awal (0 byte).
- Bukti: login dengan kunci yang sudah dihapus gagal, layanan SSH tetap active.
