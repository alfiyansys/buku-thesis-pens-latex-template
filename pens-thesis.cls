%% pens-thesis.cls
%% Document class for the master's thesis book (Buku Tesis S2) of
%% Politeknik Elektronika Negeri Surabaya (PENS).
%%
%% UNOFFICIAL template: not issued or endorsed by PENS. It was built with
%% "Panduan Buku Tesis S2" (Program Pascasarjana PENS) as the reference:
%%   https://old.pascasarjana.pens.ac.id/docs/panduan_buku_tesis_S2.pdf
%% Always check the current rules of your study programme before submitting.
%%
%% Class options
%%   print      (default) two-sided layout, chapters open on a right-hand page,
%%              inner margin 40 mm / outer margin 30 mm.
%%   digital    one-sided layout for the soft copy (left 40 mm, right 30 mm),
%%              no blank verso pages.
%%   nocover    do not typeset the coloured hard cover as the first page
%%              (use sampul.tex to print the full hard-cover spread instead).
%%   separator  fill the blank page in front of every chapter with the PENS
%%              logo pattern (the guide's "halaman pemisah").
%%   pattern    put the PENS logo pattern behind the approval page
%%              (mimics the pre-printed approval sheet).
%%   draft      passed on to graphicx etc.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pens-thesis}[2026/11/18 v1.0 PENS Buku Tesis S2]

% ---------------------------------------------------------------------------
% Options
% ---------------------------------------------------------------------------
\newif\ifpens@print   \pens@printtrue
\newif\ifpens@cover   \pens@covertrue
\newif\ifpens@sep     \pens@sepfalse
\newif\ifpens@pattern \pens@patternfalse

\DeclareOption{print}{\pens@printtrue}
\DeclareOption{digital}{\pens@printfalse}
\DeclareOption{nocover}{\pens@coverfalse}
\DeclareOption{separator}{\pens@septrue}
\DeclareOption{pattern}{\pens@patterntrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\ifpens@print
  \LoadClass[a4paper,12pt,twoside,openright,fleqn]{book}
\else
  \LoadClass[a4paper,12pt,oneside,openany,fleqn]{book}
\fi

% ---------------------------------------------------------------------------
% Packages
% ---------------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
% Times New Roman look-alike. newtx is preferred (Overleaf / full TeX Live);
% fall back to TeX Gyre Termes + mathptmx on minimal installations.
\IfFileExists{newtxtext.sty}{%
  \RequirePackage{newtxtext}%
  \RequirePackage{newtxmath}%
}{%
  \RequirePackage{mathptmx}%
  \IfFileExists{tgtermes.sty}{\RequirePackage{tgtermes}}{}%
}
\IfFileExists{lmodern.sty}{\renewcommand{\ttdefault}{lmtt}}{}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{graphicx}
\RequirePackage[table]{xcolor}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{indentfirst}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage[titles]{tocloft}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{etoolbox}
\RequirePackage{tikz}
\usetikzlibrary{positioning,arrows.meta,calc}
\RequirePackage{url}
\RequirePackage[numbers,sort&compress,square,comma]{natbib}
\RequirePackage[hidelinks,bookmarksnumbered]{hyperref}

% ---------------------------------------------------------------------------
% Colours (from the guide)
% ---------------------------------------------------------------------------
\definecolor{pensblue}{RGB}{0,43,166}
\definecolor{pensyellow}{RGB}{242,203,0}
\definecolor{penstablehead}{gray}{0.80}
\definecolor{pensseparator}{RGB}{214,234,246}

% ---------------------------------------------------------------------------
% Page layout: A4, left/inner 40 mm, right/outer 30 mm, top/bottom 30 mm
% ---------------------------------------------------------------------------
\geometry{a4paper,inner=40mm,outer=30mm,top=30mm,bottom=30mm,
  footskip=12mm,headheight=0pt,headsep=0pt}

% Line spacing 1.5, paragraph indentation 10 mm, no space between paragraphs
\onehalfspacing
\setlength{\parindent}{10mm}
\setlength{\parskip}{0pt}

% Page numbers centred at the bottom of every page
\pagestyle{plain}

% ---------------------------------------------------------------------------
% Indonesian names (no babel dependency)
% ---------------------------------------------------------------------------
\renewcommand{\contentsname}{DAFTAR ISI}
\renewcommand{\listfigurename}{DAFTAR GAMBAR}
\renewcommand{\listtablename}{DAFTAR TABEL}
\renewcommand{\bibname}{DAFTAR PUSTAKA}
\renewcommand{\chaptername}{BAB}
\renewcommand{\appendixname}{LAMPIRAN}
\renewcommand{\figurename}{Gambar}
\renewcommand{\tablename}{Tabel}
\newcommand{\equationname}{Persamaan}

% ---------------------------------------------------------------------------
% Metadata
% ---------------------------------------------------------------------------
\newcommand{\pens@judul}{JUDUL TESIS}
\newcommand{\pens@judulen}{}
\newcommand{\pens@penulis}{Nama Mahasiswa}
\newcommand{\pens@nrp}{..........................}
\newcommand{\pens@programstudi}{TEKNIK INFORMATIKA DAN KOMPUTER}
\newcommand{\pens@pascasarjana}{PROGRAM PASCASARJANA TEKNOLOGI REKAYASA}
\newcommand{\pens@institusi}{POLITEKNIK ELEKTRONIKA NEGERI SURABAYA}
\newcommand{\pens@gelar}{Magister Terapan (M.T.)}
\newcommand{\pens@tahun}{\the\year}
\newcommand{\pens@kota}{Surabaya}
\newcommand{\pens@tanggal}{..................}
\newcommand{\pens@pengesah}{Nama Ketua Program Pascasarjana}
\newcommand{\pens@pengesahnip}{............................}
\newcommand{\pens@jabatanpengesah}{Ketua Program Pascasarjana}
\newcommand{\pens@utama}{Nama Pembimbing Utama}
\newcommand{\pens@utamanip}{}
\newcommand{\pens@pendamping}{}
\newcommand{\pens@pendampingnip}{}
\newcommand{\pens@pengujilist}{}
\newcommand{\pens@logo}{figures/logo-pens.png}
\newcommand{\pens@logogray}{figures/logo-pens-gray.png}

\newcommand{\judul}[1]{\renewcommand{\pens@judul}{#1}}
\newcommand{\judulinggris}[1]{\renewcommand{\pens@judulen}{#1}}
\newcommand{\penulis}[1]{\renewcommand{\pens@penulis}{#1}}
\newcommand{\nrp}[1]{\renewcommand{\pens@nrp}{#1}}
\newcommand{\programstudi}[1]{\renewcommand{\pens@programstudi}{#1}}
\newcommand{\pascasarjana}[1]{\renewcommand{\pens@pascasarjana}{#1}}
\newcommand{\institusi}[1]{\renewcommand{\pens@institusi}{#1}}
\newcommand{\gelar}[1]{\renewcommand{\pens@gelar}{#1}}
\newcommand{\tahun}[1]{\renewcommand{\pens@tahun}{#1}}
\newcommand{\kota}[1]{\renewcommand{\pens@kota}{#1}}
\newcommand{\tanggalpernyataan}[1]{\renewcommand{\pens@tanggal}{#1}}
\newcommand{\logo}[2]{\renewcommand{\pens@logo}{#1}\renewcommand{\pens@logogray}{#2}}
% \pembimbingutama{Nama lengkap dan gelar}{NIP}
\newcommand{\pembimbingutama}[2]{%
  \renewcommand{\pens@utama}{#1}\renewcommand{\pens@utamanip}{#2}}
% \pembimbingpendamping{Nama lengkap dan gelar}{NIP}  (optional)
\newcommand{\pembimbingpendamping}[2]{%
  \renewcommand{\pens@pendamping}{#1}\renewcommand{\pens@pendampingnip}{#2}}
% \penguji{Nama lengkap dan gelar}{NIP}  (call once per examiner)
\newcommand{\penguji}[2]{%
  \g@addto@macro\pens@pengujilist{\pens@signrow{Penguji}{#1}{#2}}}
% \pengesah{Nama}{NIP} and optional \jabatanpengesah{...}
\newcommand{\pengesah}[2]{%
  \renewcommand{\pens@pengesah}{#1}\renewcommand{\pens@pengesahnip}{#2}}
\newcommand{\jabatanpengesah}[1]{\renewcommand{\pens@jabatanpengesah}{#1}}

% Hyperref metadata
\AtBeginDocument{\hypersetup{pdftitle={\pens@judul},pdfauthor={\pens@penulis}}}

% ---------------------------------------------------------------------------
% Chapter and section headings
% ---------------------------------------------------------------------------
% Chapter: "BAB n" / TITLE, centred, bold, 14 pt, upper case, then
% 3 blank lines (1.5 spacing) before the text.
\titleformat{\chapter}[display]
  {\centering\bfseries\fontsize{14}{21}\selectfont}
  {\chaptertitlename\ \thechapter}{0pt}{\MakeUppercase}
\titleformat{name=\chapter,numberless}[display]
  {\centering\bfseries\fontsize{14}{21}\selectfont}{}{0pt}{\MakeUppercase}
\titlespacing*{\chapter}{0pt}{0pt}{3\baselineskip}

% Section: "1.1  TITLE", 12 pt bold, upper case, one blank line before/after
\titleformat{\section}[hang]
  {\normalsize\bfseries}{\makebox[13mm][l]{\thesection}}{0pt}{\MakeUppercase}
\titlespacing*{\section}{0pt}{\baselineskip}{\baselineskip}

% Subsection: "1.1.1  Title", 12 pt bold, first letters capitalised
\titleformat{\subsection}[hang]
  {\normalsize\bfseries}{\makebox[16mm][l]{\thesubsection}}{0pt}{}
\titlespacing*{\subsection}{0pt}{\baselineskip}{\baselineskip}

% Deeper levels are unnumbered run-in headings
\titleformat{\subsubsection}[hang]{\normalsize\bfseries\itshape}{}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{0.5\baselineskip}{0.5\baselineskip}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}

% A chapter in print mode starts on a right-hand page; the blank page in
% front of it becomes the separator page when the `separator' option is on.
\newcommand{\pens@patternpage}{%
  \thispagestyle{empty}%
  \begin{tikzpicture}[remember picture,overlay]
    \fill[pensseparator] (current page.south west) rectangle (current page.north east);
    \foreach \x in {0,...,6} {\foreach \y in {0,...,9} {
      \node at ([xshift=15mm+\x*30mm,yshift=-15mm-\y*30mm]current page.north west)
        {\includegraphics[width=14mm]{\pens@logo}};}}
  \end{tikzpicture}%
  \null\newpage}
% In the main matter every chapter gets a separator on the left-hand page,
% so the chapter itself starts on the right-hand page.
\ifpens@print\ifpens@sep
  \renewcommand{\cleardoublepage}{%
    \clearpage
    \if@mainmatter
      \ifodd\c@page\hbox{}\thispagestyle{empty}\newpage\fi
      \pens@patternpage
    \else
      \ifodd\c@page\else\hbox{}\thispagestyle{empty}\newpage\fi
    \fi}
\fi\fi
% Blank verso pages carry no page number
\ifpens@print\ifpens@sep\else
  \renewcommand{\cleardoublepage}{%
    \clearpage\ifodd\c@page\else\hbox{}\thispagestyle{empty}\newpage\fi}
\fi\fi

% ---------------------------------------------------------------------------
% Table of contents, list of figures, list of tables
% ---------------------------------------------------------------------------
\renewcommand{\cftdotsep}{2}
\renewcommand{\cftchapdotsep}{\cftnodots}
\newcommand{\pens@tocfront}{%
  \renewcommand{\cftchapfont}{\normalfont}%
  \renewcommand{\cftchappagefont}{\normalfont}%
  \setlength{\cftbeforechapskip}{0pt}}
\newcommand{\pens@tocmain}{%
  \renewcommand{\cftchapfont}{\bfseries}%
  \renewcommand{\cftchappagefont}{\bfseries}%
  \setlength{\cftbeforechapskip}{1.2\baselineskip}}
\pens@tocfront
\renewcommand{\cftchappresnum}{}
\setlength{\cftchapnumwidth}{1.5em}
\setlength{\cftsecindent}{1.5em}
\setlength{\cftsecnumwidth}{3em}
\setlength{\cftsubsecindent}{4.5em}
\setlength{\cftsubsecnumwidth}{3.5em}
\renewcommand{\cftfigpresnum}{\figurename\ }
\renewcommand{\cfttabpresnum}{\tablename\ }
\setlength{\cftfignumwidth}{6em}
\setlength{\cfttabnumwidth}{5.5em}
\setlength{\cftfigindent}{0pt}
\setlength{\cfttabindent}{0pt}
% With [titles], the three list titles use the \chapter* heading style
% Section titles appear in upper case in the TOC, as in the guide
\let\pens@oldl@section\l@section
\renewcommand{\l@section}[2]{\pens@oldl@section{\MakeUppercase{#1}}{#2}}
\let\pens@oldl@chapter\l@chapter
\renewcommand{\l@chapter}[2]{\pens@oldl@chapter{\MakeUppercase{#1}}{#2}}

% Front-matter pages listed in the TOC
\newcommand{\pens@tocentry}[1]{%
  \phantomsection\addcontentsline{toc}{chapter}{#1}}
% Entries without page number (cover page, approval page)
\newcommand{\pens@tocentrynopage}[1]{%
  \addtocontents{toc}{\protect\contentsline{chapter}{#1}{}{}}}

\newcommand{\daftarisi}{%
  \clearpage\pens@tocentry{DAFTAR ISI}\tableofcontents}
\newcommand{\daftargambar}{%
  \clearpage\pens@tocentry{DAFTAR GAMBAR}\listoffigures}
\newcommand{\daftartabel}{%
  \clearpage\pens@tocentry{DAFTAR TABEL}\listoftables}
% Space between chapters in LoF/LoT removed (single list as in the guide)
\patchcmd{\@chapter}{\addtocontents{lof}{\protect\addvspace{10\p@}}}{}{}{}
\patchcmd{\@chapter}{\addtocontents{lot}{\protect\addvspace{10\p@}}}{}{}{}

% Unnumbered front/back-matter chapter that still appears in the TOC
\newcommand{\babtanpanomor}[1]{%
  \chapter*{#1}\pens@tocentry{#1}}

% ---------------------------------------------------------------------------
% Figures, tables, equations
% ---------------------------------------------------------------------------
% Caption: "Gambar 3.1. Keterangan", centred, bold
\captionsetup{font={normalsize,bf},labelsep=period,justification=centering,
  singlelinecheck=false,skip=0.5\baselineskip}
\captionsetup[table]{position=top}
% One blank line above and below floats
\setlength{\intextsep}{\baselineskip}
\setlength{\textfloatsep}{\baselineskip}
\setlength{\floatsep}{\baselineskip}
\renewcommand{\arraystretch}{1.2}

% \sumber{...}: source of a quoted figure/table, centred, 10 pt
\newcommand{\sumber}[1]{%
  \par\vspace{0.25\baselineskip}%
  {\centering\fontsize{10}{12}\selectfont Sumber: #1\par}%
  \vspace{0.25\baselineskip}}
% \headrow: shaded, bold header row of a table
\newcommand{\headrow}{\rowcolor{penstablehead}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}

% Equations: left-aligned, indented 10 mm, number right-aligned and bold
\setlength{\mathindent}{10mm}
\def\tagform@#1{\maketag@@@{\bfseries(\ignorespaces#1\unskip\@@italiccorr)}}
\renewcommand{\eqref}[1]{\textup{\ref{#1}}}
\setlength{\abovedisplayskip}{\baselineskip}
\setlength{\belowdisplayskip}{\baselineskip}
\AtBeginDocument{%
  \setlength{\abovedisplayskip}{\baselineskip}%
  \setlength{\belowdisplayskip}{\baselineskip}}

% Lists without extra vertical space
\setlist{nosep}
\setlist[enumerate]{leftmargin=*}

% ---------------------------------------------------------------------------
% Quotations
% ---------------------------------------------------------------------------
% Short direct quotation (1-2 lines): "italic text" followed by \cite
\newcommand{\kutipan}[1]{``\textit{#1}''}
% Long direct quotation (> 2 lines): separate paragraph, 10 pt,
% left/right margin 10 mm, enclosed in double quotes, citation after it:
%   \begin{kutipanpanjang}[\cite{key}] ... \end{kutipanpanjang}
\newenvironment{kutipanpanjang}[1][]
  {\par\vspace{0.5\baselineskip}%
   \def\pens@quotecite{#1}%
   \list{}{\leftmargin=10mm\rightmargin=10mm\listparindent=0pt}%
   \item\relax\fontsize{10}{15}\selectfont``\ignorespaces}
  {\unskip''\ifx\pens@quotecite\@empty\else~\pens@quotecite\fi
   \endlist\vspace{0.5\baselineskip}}

% ---------------------------------------------------------------------------
% Signature row helper (approval page)
% ---------------------------------------------------------------------------
\newcommand{\pens@signrow}[3]{%
  #1 & : & \underline{#2} & (\hspace{22mm}) \\
     &   & NIP. #3 & \\[1.2\baselineskip]}

% ---------------------------------------------------------------------------
% Cover pages
% ---------------------------------------------------------------------------
% Shared content of the cover and the title page
\newcommand{\pens@titleblock}{%
  {\fontsize{16}{20}\selectfont\bfseries\MakeUppercase{\pens@judul}\par}
  \vspace{18mm}
  {\fontsize{14}{18}\selectfont\bfseries\pens@penulis\par}
  {\fontsize{14}{18}\selectfont NRP. \pens@nrp\par}
  \vspace{16mm}
  {\fontsize{14}{18}\selectfont\bfseries DOSEN PEMBIMBING\par}
  \vspace{4mm}
  {\fontsize{14}{18}\selectfont\bfseries\pens@utama\par
   \ifx\pens@pendamping\@empty\else\pens@pendamping\par\fi}
  \vfill
  {\fontsize{14}{18}\selectfont\bfseries
   PROGRAM STUDI MAGISTER TERAPAN\par
   \MakeUppercase{\pens@programstudi}\par
   \MakeUppercase{\pens@pascasarjana}\par
   \MakeUppercase{\pens@institusi}\par
   \pens@tahun\par}}

% Hard cover (front): white top area 70 mm with logo and "TESIS",
% 5 mm yellow band, blue bottom area 222 mm with white text.
\newcommand{\pens@hardcover}{%
  \begin{titlepage}
  \begin{tikzpicture}[remember picture,overlay]
    \coordinate (NW) at (current page.north west);
    \fill[pensblue] ([yshift=-75mm]NW) rectangle (current page.south east);
    \fill[pensyellow] ([yshift=-70mm]NW) rectangle ([xshift=210mm,yshift=-75mm]NW);
    \node[anchor=center] at ([xshift=45mm,yshift=-35mm]NW)
      {\includegraphics[height=30mm,width=30mm,keepaspectratio]{\pens@logo}};
    \node[anchor=center,text=pensblue,font=\fontsize{24}{28}\selectfont\bfseries]
      at ([xshift=150mm,yshift=-35mm]NW) {TESIS};
    \node[anchor=north,text=white,text width=150mm,align=center,
          minimum height=185mm,inner sep=0pt]
      at ([xshift=105mm,yshift=-110mm]NW)
      {\begin{minipage}[t][185mm]{150mm}\centering\linespread{1}\selectfont
         \pens@titleblock\end{minipage}};
  \end{tikzpicture}
  \end{titlepage}}

% Title page: same layout on white paper, grayscale logo, black text.
\newcommand{\pens@titlepage}{%
  \begin{titlepage}
  \begin{tikzpicture}[remember picture,overlay]
    \coordinate (NW) at (current page.north west);
    \node[anchor=center] at ([xshift=45mm,yshift=-35mm]NW)
      {\includegraphics[height=30mm,width=30mm,keepaspectratio]{\pens@logogray}};
    \node[anchor=center,font=\fontsize{24}{28}\selectfont\bfseries]
      at ([xshift=150mm,yshift=-35mm]NW) {TESIS};
    \node[anchor=north,inner sep=0pt] at ([xshift=105mm,yshift=-110mm]NW)
      {\begin{minipage}[t][185mm]{150mm}\centering\linespread{1}\selectfont
         \pens@titleblock\end{minipage}};
  \end{tikzpicture}
  \end{titlepage}}

% ---------------------------------------------------------------------------
% Approval page (Halaman Pengesahan)
% ---------------------------------------------------------------------------
\newcommand{\halamanpengesahan}{%
  \cleardoublepage
  \thispagestyle{empty}%
  \pens@tocentrynopage{HALAMAN PENGESAHAN}%
  \ifpens@pattern
    \begin{tikzpicture}[remember picture,overlay]
      \foreach \x in {0,...,6} {\foreach \y in {0,...,9} {
        \node[opacity=0.35] at ([xshift=15mm+\x*30mm,yshift=-15mm-\y*30mm]current page.north west)
          {\includegraphics[width=14mm]{\pens@logo}};}}
    \end{tikzpicture}%
  \fi
  \begin{center}\singlespacing
    {\fontsize{14}{18}\selectfont\bfseries HALAMAN PENGESAHAN\par}
    \vspace{10mm}
    {\bfseries\MakeUppercase{\pens@judul}\par}
    \vspace{6mm}
    Oleh:\par
    {\bfseries\pens@penulis\par NRP. \pens@nrp\par}
    \vspace{8mm}
    {\bfseries Tesis ini digunakan sebagai salah satu syarat untuk memperoleh\par
     Gelar \pens@gelar\par di\par
     \pens@institusi@title\par \pens@tahun\par}
    \vspace{10mm}
    {\bfseries Disetujui oleh:\par}
    \vspace{6mm}
  \end{center}
  {\singlespacing\noindent
  \begin{tabular}{@{}p{44mm}@{}p{4mm}@{}p{65mm}@{}l@{}}
    \pens@signrow{Pembimbing Utama}{\pens@utama}{\pens@utamanip}
    \ifx\pens@pendamping\@empty\else
      \pens@signrow{Pembimbing Pendamping}{\pens@pendamping}{\pens@pendampingnip}
    \fi
    \pens@pengujilist
  \end{tabular}\par}
  \begin{center}\singlespacing
    \vspace{4mm}
    {\bfseries Mengetahui,\par}
    \vspace{4mm}
    \pens@jabatanpengesah\par \pens@institusi@title\par
    \vspace{20mm}
    \underline{\pens@pengesah}\par NIP. \pens@pengesahnip\par
  \end{center}
  \clearpage}
% Institution name in title case for running text
\newcommand{\pens@institusi@title}{Politeknik Elektronika Negeri Surabaya}
\newcommand{\institusikalimat}[1]{\renewcommand{\pens@institusi@title}{#1}}

% ---------------------------------------------------------------------------
% Statement pages
% ---------------------------------------------------------------------------
\newcommand{\pens@signature}{%
  \par\vspace{15mm}
  {\setlength{\parindent}{0pt}\hspace*{0.55\textwidth}%
   \begin{minipage}[t]{0.45\textwidth}
     \pens@kota, \pens@tanggal\par\vspace{\baselineskip}
     Yang menyatakan,\par\vspace{25mm}
     (\pens@penulis)
   \end{minipage}\par}}

\newcommand{\halamanorisinalitas}{%
  \clearpage
  \babtanpanomor{HALAMAN PERNYATAAN ORISINALITAS}
  \noindent Dengan ini saya menyatakan bahwa bagian atau keseluruhan tesis ini:
  \begin{enumerate}[label=\arabic*.,leftmargin=10mm,topsep=\baselineskip]
    \item adalah hasil karya sendiri dan tidak mengandung unsur plagiat dari
      pihak lain
    \item tidak pernah diajukan untuk mendapatkan gelar akademis pada suatu
      Perguruan Tinggi
    \item tidak pernah dipublikasikan atau ditulis oleh pihak lain
    \item mencantumkan rujukan dan kutipan dengan jujur dan benar terhadap
      sumber referensi lain yang menunjang pembahasan pada tesis.
  \end{enumerate}
  \vspace{\baselineskip}
  \noindent Apabila ditemukan bukti bahwa pernyataan saya diatas tidak benar,
  maka saya bersedia menerima sanksi sesuai dengan ketentuan yang berlaku di
  \pens@institusi@title.
  \pens@signature}

\newcommand{\halamanpublikasi}{%
  \clearpage
  \babtanpanomor{HALAMAN KESEPAKATAN PUBLIKASI}
  \noindent Demi pengembangan ilmu pengetahuan, dengan ini saya menyatakan:
  \begin{enumerate}[label=\arabic*.,leftmargin=10mm,topsep=\baselineskip]
    \item memberikan persetujuan kepada \pens@institusi@title{} untuk
      menyimpan, mengolah dalam bentuk pangkalan data, merawat,
      mengalihmedia/formatkan dan mempublikasikan tesis ini selama tetap
      mencantumkan nama saya sebagai penulis/pencipta dan sebagai pemilik
      Hak Cipta.
    \item tidak melakukan alihmedia/format dan publikasi dalam bentuk makalah
      ilmiah dari bagian atau keseluruhan tesis ini ke suatu publikasi
      ilmiah, pada seminar ataupun jurnal, skala nasional ataupun
      internasional, kecuali ada persetujuan dari saya dan Dosen Pembimbing
      Utama, dan mencantumkan nama saya, Dosen Pembimbing Utama dan
      nama-nama lain (jika ada) yang berkontribusi pada makalah.
  \end{enumerate}
  \pens@signature}

% ---------------------------------------------------------------------------
% Abstract
% ---------------------------------------------------------------------------
% \begin{abstrak}{kata kunci 1, kata kunci 2} ... \end{abstrak}
\newenvironment{abstrak}[1]
  {\clearpage\babtanpanomor{ABSTRAK}\def\pens@keywords{#1}}
  {\par\vspace{2\baselineskip}\noindent\textbf{Kata Kunci}\par
   \vspace{0.5\baselineskip}\noindent\pens@keywords\par}
% Optional English abstract: \begin{abstract}{keyword 1, keyword 2}
\newenvironment{abstract}[1]
  {\clearpage\babtanpanomor{ABSTRACT}\def\pens@keywords{#1}}
  {\par\vspace{2\baselineskip}\noindent\textbf{Keywords}\par
   \vspace{0.5\baselineskip}\noindent\pens@keywords\par}

% ---------------------------------------------------------------------------
% Document structure helpers
% ---------------------------------------------------------------------------
% \halamanjudul: hard cover (unless nocover) + blank sheet + title page
\newcommand{\halamanjudul}{%
  \@mainmatterfalse
  \pagenumbering{alph}% invisible numbers for the cover pages
  \ifpens@cover
    \pens@hardcover
    \ifpens@print\hbox{}\thispagestyle{empty}\newpage\fi
  \fi
  \pens@tocentrynopage{HALAMAN JUDUL}%
  \pens@titlepage
  \ifpens@print\hbox{}\thispagestyle{empty}\newpage\fi}

% Roman numbering starts at the originality statement (page i). Front-matter
% pages follow each other directly; only chapters open on a right-hand page.
\newcommand{\mulaiprakata}{\cleardoublepage\pagenumbering{roman}\@openrightfalse}
\g@addto@macro\mainmatter{%
  \ifpens@print\@openrighttrue\fi
  \addtocontents{toc}{\protect\pens@tocmain}}
\g@addto@macro\backmatter{\@openrightfalse}

% Bibliography: listed in the TOC, sorted by author (pens.bst)
\newcommand{\daftarpustaka}[1]{%
  \clearpage
  \phantomsection\addcontentsline{toc}{chapter}{DAFTAR PUSTAKA}%
  \bibliographystyle{pens}%
  \bibliography{#1}}
\renewenvironment{thebibliography}[1]
  {\chapter*{\bibname}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
     {\settowidth\labelwidth{\@biblabel{#1}}%
      \leftmargin\labelwidth\advance\leftmargin\labelsep
      \itemsep=0.5\baselineskip\parsep=0pt
      \@openbib@code\usecounter{enumiv}%
      \let\p@enumiv\@empty\renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy\clubpenalty4000\@clubpenalty\clubpenalty\widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}

% Appendices: "LAMPIRAN" in the TOC, appendix chapters titled "LAMPIRAN A"
\newcommand{\lampiran}{%
  \clearpage
  \appendix
  \@mainmattertrue
  \phantomsection\addcontentsline{toc}{chapter}{LAMPIRAN}%
  \titleformat{\chapter}[display]
    {\centering\bfseries\fontsize{14}{21}\selectfont}
    {\appendixname\ \thechapter}{0pt}{\MakeUppercase}%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{-1}}}

\endinput
