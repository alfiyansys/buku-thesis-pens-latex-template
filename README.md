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

Ukuran, posisi dan urutan halaman **diukur langsung dari PDF panduan** (koordinat teks dalam mm),
lalu hasil build dibandingkan baris per baris dengan panduan. Contoh isi (`chapters/` dan
lain-lain) memakai teks panduan apa adanya, sehingga hasilnya bisa disandingkan langsung.

## Isi repo

| Path | Keterangan |
|---|---|
| `pens-thesis.cls` | Document class: tata letak, heading, halaman awal, sampul, pemisah, caption, kutipan |
| `pens.bst` | Gaya BibTeX daftar pustaka (format dan urutan sesuai panduan) |
| `main.tex` | Dokumen utama: urutan bagian buku tesis |
| `config/metadata.tex` | Data tesis: judul, mahasiswa, NRP, pembimbing, penguji, prodi, tahun |
| `frontmatter/` | Kata pengantar, abstrak |
| `chapters/` | Bab 1 sampai Bab 5 (isi contoh = teks panduan) |
| `backmatter/lampiran.tex` | Lampiran |
| `references.bib` | Contoh entri untuk keenam jenis sumber di panduan |
| `sampul.tex` | Bentangan hard cover untuk percetakan: sampul belakang, punggung, sampul depan |
| `figures/` | Logo PENS berwarna (sampul), grayscale (halaman judul), simbol teal (halaman pemisah) |

## Cara pakai

1. Isi `config/metadata.tex`.
2. Tulis isi di `frontmatter/`, `chapters/`, `backmatter/`; pustaka di `references.bib`.
3. Build dengan **XeLaTeX** (disarankan) atau LuaLaTeX:

   ```sh
   make            # main.pdf  (xelatex -> bibtex -> xelatex x2)
   make cover      # sampul.pdf
   make clean
   ```

   Tanpa `make`: `xelatex main && bibtex main && xelatex main && xelatex main`.
   Di Overleaf: Menu → Compiler → XeLaTeX.

### Font

Panduan ditulis di Word dengan **Times New Roman** (isi) dan **Calibri** (nomor halaman).

- XeLaTeX/LuaLaTeX memakai Times New Roman bila terpasang, lalu **Liberation Serif** (metrik
  identik dengan Times New Roman), lalu TeX Gyre Termes. Untuk nomor halaman: Calibri, lalu
  Carlito, lalu font isi.
- Seperti Word, *kerning*, ligatur fi/fl, dan pemenggalan kata dimatikan, spasi antarkata tidak
  dipersempit, dan *widow/orphan control* aktif.
- pdfLaTeX tetap bisa dipakai (newtx atau TeX Gyre Termes), tetapi hurufnya sekitar 1% lebih
  sempit dari Times New Roman sehingga pemotongan baris bisa berbeda dari Word.

### Opsi class

```latex
\documentclass[print]{pens-thesis}
```

| Opsi | Efek |
|---|---|
| `print` (default) | Urutan halaman buku cetak sesuai panduan: halaman awal dan setiap bab di halaman kanan; halaman kosong, lembar pemisah dan kertas karton disisipkan **tanpa nomor halaman** |
| `digital` | PDF tanpa halaman kosong, pemisah dan karton |
| `nocover` | Tanpa hard cover (sampul depan, balik sampul, sampul belakang); cetak sampul dengan `sampul.tex` |
| `noseparator` | Tanpa lembar pemisah sebelum bab |
| `nokarton` | Tanpa lembar karton setelah sampul depan dan sebelum sampul belakang |

## Ketentuan panduan yang diterapkan

- **Kertas dan margin:** A4, kiri 40 mm, kanan 30 mm, atas 30 mm, bawah 30 mm (sama di semua
  halaman, seperti di panduan). Nomor halaman di tengah, 17,8 mm dari tepi bawah, Calibri 11 pt.
- **Huruf dan spasi:** Times 12 pt, spasi 1,5 ala Word (20,7 pt antarbaris), indentasi paragraf
  10 mm, rata kiri-kanan, tanpa pemenggalan kata.
- **Urutan halaman (print):** hard cover, balik sampul, karton (2 halaman), halaman judul,
  pengesahan, lalu orisinalitas (i), kesepakatan publikasi (ii), kata pengantar, abstrak, daftar
  isi, daftar gambar, daftar tabel, masing-masing mulai di halaman kanan. Lembar pemisah (dua
  sisi) sebelum setiap bab, Daftar Pustaka dan Lampiran. Di akhir: karton, sampul belakang.
- **Bab:** `BAB n` + judul, 14 pt tebal huruf besar, rata tengah, baseline 34,8 mm dari tepi atas,
  3 × 1,5 spasi kosong sebelum teks.
- **Subbab:** `1.1` + 5 spasi + `JUDUL` (tebal huruf besar); `1.1.1` + 5 spasi + `Judul` (tebal);
  satu baris kosong sebelum dan sesudah.
- **Halaman pemisah:** biru muda RGB (218,238,243) dengan simbol PENS teal yang berselang-seling,
  tanpa tulisan.
- **Hard cover:** biru RGB (0,43,166); area atas putih 70 mm dengan logo 30 × 30 mm dan "TESIS"
  24 pt; pemisah kuning RGB (242,203,0) 5 mm; judul 16 pt; nama/pembimbing 14 pt; prodi 16 pt.
- **Halaman judul:** kertas putih, logo grayscale, prodi 14 pt.
- **Halaman pengesahan:** spasi tunggal, rata tengah halaman, kolom tanda tangan.
  *Watermark* (latar logo) kertas pengesahan dicetak terpisah dan tidak termasuk template.
- **Daftar isi:** entri halaman awal tebal, bab tebal, subbab dengan titik-titik; Daftar Pustaka
  dan Lampiran tanpa nomor halaman.
- **Gambar dan tabel:** satu baris kosong di atas dan bawah, nomor `Bab.Urutan`, keterangan tebal
  rata tengah (gambar: di bawah; tabel: di atas, seperti contoh panduan), sumber kutipan 10 pt,
  tabel berkisi dengan judul kolom tebal berlatar gelap, tinggi baris 7,5 mm.
- **Persamaan:** rata kiri masuk 10 mm, nomor `(3.1)` rata kanan dan tebal.
- **Kutipan:** pendek dengan tanda petik dan miring; panjang 10 pt, masuk 10 mm kiri-kanan.
- **Daftar pustaka:** nomor `1.` di margin, teks masuk 7,5 mm, urut nama pengarang; judul tebal;
  nama jurnal/seminar/penerbit buku/perguruan tinggi/media/alamat internet miring.

## Perintah penting

| Perintah | Kegunaan |
|---|---|
| `\halamanjudul`, `\halamanpengesahan` | Hard cover + karton + halaman judul; halaman pengesahan |
| `\mulaiprakata` | Mulai penomoran romawi (halaman i) |
| `\halamanorisinalitas`, `\halamanpublikasi` | Halaman pernyataan dari panduan |
| `\babtanpanomor{JUDUL}` | Bab tanpa nomor yang tetap masuk daftar isi |
| `\begin{abstrak}{kata kunci}` | Abstrak + kata kunci (`abstract` untuk versi Inggris) |
| `\daftarisi`, `\daftargambar`, `\daftartabel` | Daftar isi, gambar, tabel |
| `\begin{sistematika}` + `\babsistematika{Bab 1}{Judul}{Penjelasan}` | Daftar "Sistematika Penulisan" |
| `\sumber{...}` | Sumber gambar/tabel kutipan (10 pt, rata tengah) |
| `\headrow` | Baris judul tabel berlatar gelap |
| `\kutipan{...}` | Kutipan langsung pendek |
| `\begin{kutipanpanjang}[\cite{key}]` | Kutipan langsung panjang |
| `\daftarpustaka{references}` | Daftar pustaka dengan `pens.bst` |
| `\lampiran` | Halaman Lampiran |
| `\sampulbelakang` | Karton + sampul belakang di akhir buku |

## Perbedaan yang diketahui dengan panduan

- **Anotasi vs gambar contoh.** Bila keterangan (balon anotasi) panduan berbeda dengan gambar
  contohnya, template mengikuti anotasi: judul tesis di sampul/halaman judul 16 pt (gambar contoh
  ±20 pt) dan nama pembimbing tebal (gambar contoh tidak tebal).
- **Pemotongan baris.** Word memotong baris secara *first-fit*, sedangkan TeX mengoptimalkan satu
  paragraf sekaligus. Dengan pengaturan di atas, sebagian besar baris contoh terpotong sama dengan
  panduan; sebagian kecil paragraf bisa terpotong berbeda satu kata.
- **Ketidakkonsistenan panduan** tidak ditiru: di daftar isi panduan Bab 4 berjudul "Eksperimen dan
  Ujicoba", di halaman babnya "Eksperimen dan Analisis"; template memakai satu judul.
- **Logo** di `figures/` diambil dari PDF panduan dan resolusinya rendah (138 px). Untuk dicetak,
  ganti dengan logo resolusi tinggi lewat `\logo{berwarna}{grayscale}` (dan
  `\logopemisah{...}`) di `config/metadata.tex`.
- **Nama lembaga** mengikuti panduan 2015 (`PROGRAM PASCASARJANA TEKNOLOGI REKAYASA`). Ubah lewat
  `\pascasarjana{...}`, `\programstudi{...}`, `\pengesah{...}{...}`, `\jabatanpengesah{...}`.
- **Lebar punggung** di `sampul.tex` (`\punggung`, default 20 mm) tergantung jumlah halaman.
  Tanyakan ke percetakan.
