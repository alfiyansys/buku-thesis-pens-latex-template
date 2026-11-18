# Buku Tesis PENS: Template LaTeX (Unofficial)

Template LaTeX untuk **buku tesis Program Magister Terapan, Politeknik Elektronika Negeri Surabaya
(PENS)**.

> **Unofficial.** Template ini **tidak resmi**: tidak diterbitkan maupun disahkan oleh PENS atau
> Program Pascasarjana PENS. Template ini dibuat dengan acuan dokumen panduan resmi
> **Panduan Buku Tesis S2**:
> <https://old.pascasarjana.pens.ac.id/docs/panduan_buku_tesis_S2.pdf>
>
> Panduan tersebut bertahun 2015. Selalu cocokkan dengan ketentuan terbaru dari program studi dan
> dosen pembimbing sebelum mencetak atau mengumpulkan buku tesis.

## Isi repo

| Path | Keterangan |
|---|---|
| `pens-thesis.cls` | Document class: tata letak, heading, halaman awal, caption, kutipan |
| `pens.bst` | Gaya BibTeX daftar pustaka (nomor `[n]`, urut nama pengarang) |
| `main.tex` | Dokumen utama: urutan bagian buku tesis |
| `config/metadata.tex` | Data tesis: judul, mahasiswa, NRP, pembimbing, penguji, prodi, tahun |
| `frontmatter/` | Kata pengantar, abstrak |
| `chapters/` | Bab 1 sampai Bab 5 (isi contoh dari panduan) |
| `backmatter/lampiran.tex` | Lampiran |
| `references.bib` | Contoh entri pustaka untuk setiap jenis sumber di panduan |
| `sampul.tex` | Bentangan hard cover untuk percetakan: sampul belakang, punggung, sampul depan |
| `figures/` | Logo PENS berwarna (sampul) dan grayscale (halaman judul) |

## Cara pakai

1. Isi `config/metadata.tex`.
2. Tulis isi di `frontmatter/`, `chapters/`, `backmatter/`; pustaka di `references.bib`.
3. Build:

   ```sh
   make            # main.pdf  (pdflatex -> bibtex -> pdflatex x2)
   make cover      # sampul.pdf
   make clean
   ```

   Tanpa `make`: `pdflatex main && bibtex main && pdflatex main && pdflatex main`.
   Bisa juga di Overleaf (compiler pdfLaTeX).

Kebutuhan: TeX Live dengan pdfLaTeX dan BibTeX. Font memakai `newtx` (Times) bila tersedia, dan
TeX Gyre Termes + `mathptmx` bila tidak. Tidak perlu `biber` atau `babel` bahasa Indonesia.

### Opsi class

```latex
\documentclass[print]{pens-thesis}
```

| Opsi | Efek |
|---|---|
| `print` (default) | Cetak bolak-balik: margin dalam 40 mm / luar 30 mm, bab dimulai di halaman kanan |
| `digital` | PDF satu sisi (kiri 40 mm, kanan 30 mm), tanpa halaman kosong |
| `nocover` | Tanpa hard cover berwarna di halaman pertama (pakai `sampul.tex` untuk dicetak) |
| `separator` | Halaman pemisah bermotif logo di halaman kiri sebelum setiap bab |
| `pattern` | Motif logo di belakang halaman pengesahan |

## Ketentuan panduan yang diterapkan

- **Kertas dan margin:** A4, kiri/dalam 40 mm, kanan/luar 30 mm, atas 30 mm, bawah 30 mm, cetak
  bolak-balik, halaman depan bab di halaman kanan.
- **Huruf:** Times 12 pt, spasi 1,5, indentasi paragraf 10 mm.
- **Bab:** `BAB n` + judul, tebal, huruf besar, rata tengah, diikuti 3 × 1,5 spasi kosong.
- **Subbab:** `1.1 JUDUL` tebal huruf besar; `1.1.1 Judul` tebal, awal kata huruf besar.
- **Hard cover:** biru RGB (0,43,166), area atas putih 70 mm dengan logo 30 × 30 mm dan
  "TESIS" 24 pt, pemisah kuning RGB (242,203,0) 5 mm, judul 16 pt, nama/pembimbing 14 pt.
- **Halaman judul:** tata letak sama di kertas putih, logo grayscale.
- **Halaman awal:** pengesahan (tanpa nomor), pernyataan orisinalitas (i), kesepakatan publikasi
  (ii), kata pengantar, abstrak + kata kunci, daftar isi, daftar gambar, daftar tabel.
- **Gambar dan tabel:** rata tengah, satu baris kosong di atas dan bawah, nomor `Bab.Urutan`,
  keterangan rata tengah dan tebal, sumber kutipan 10 pt, judul kolom tabel tebal berlatar gelap.
- **Persamaan:** rata kiri masuk 10 mm, nomor `(3.1)` rata kanan dan tebal.
- **Kutipan:** pendek dengan tanda petik dan huruf miring; panjang 10 pt, masuk 10 mm kiri-kanan.
- **Daftar pustaka:** urut nama pengarang, format `Pengarang, Judul, Jurnal, Vol., No., Hal.,
  Penerbit, Tahun` (dan pola serupa untuk seminar, buku, tesis, media publik, media online).
- **Sampul punggung:** nama + NRP 12 pt dan judul 14 pt, tebal, putih, vertikal.

## Perintah penting

| Perintah | Kegunaan |
|---|---|
| `\halamanjudul`, `\halamanpengesahan` | Hard cover + halaman judul; halaman pengesahan |
| `\mulaiprakata` | Mulai penomoran romawi (halaman i) |
| `\halamanorisinalitas`, `\halamanpublikasi` | Halaman pernyataan dari panduan |
| `\babtanpanomor{JUDUL}` | Bab tanpa nomor yang tetap masuk daftar isi |
| `\begin{abstrak}{kata kunci}` | Abstrak + kata kunci (`abstract` untuk versi Inggris) |
| `\daftarisi`, `\daftargambar`, `\daftartabel` | Daftar isi, gambar, tabel |
| `\sumber{...}` | Sumber gambar/tabel kutipan (10 pt, rata tengah) |
| `\headrow` | Baris judul tabel berlatar gelap |
| `\kutipan{...}` | Kutipan langsung pendek |
| `\begin{kutipanpanjang}[\cite{key}]` | Kutipan langsung panjang |
| `\daftarpustaka{references}` | Daftar pustaka dengan `pens.bst` |
| `\lampiran` | Mulai lampiran (`LAMPIRAN A`, `LAMPIRAN B`, ...) |

## Catatan

- Logo PENS di `figures/` diambil dari PDF panduan dan resolusinya rendah (138 px). Untuk
  dicetak, ganti dengan logo resolusi tinggi lewat `\logo{berwarna}{grayscale}` di
  `config/metadata.tex`.
- Lebar punggung di `sampul.tex` (`\punggung`, default 20 mm) tergantung jumlah halaman. Tanyakan
  ke percetakan.
- Nama program/pascasarjana mengikuti panduan 2015 (`PROGRAM PASCASARJANA TEKNOLOGI REKAYASA`).
  Ubah lewat `\pascasarjana{...}`, `\programstudi{...}`, `\pengesah{...}{...}` dan
  `\jabatanpengesah{...}` bila struktur organisasi sudah berubah.
