%% pens-thesis.cls
%% Document class for the master's thesis book (Buku Tesis S2) of
%% Politeknik Elektronika Negeri Surabaya (PENS).
%%
%% UNOFFICIAL template: not issued or endorsed by PENS. It was built with
%% "Panduan Buku Tesis S2" (Program Pascasarjana PENS) as the reference:
%%   https://old.pascasarjana.pens.ac.id/docs/panduan_buku_tesis_S2.pdf
%% Positions, sizes and page order were measured from that PDF.
%% Always check the current rules of your study programme before submitting.
%%
%% Class options
%%   print        (default) the book as printed: every chapter and every
%%                front-matter page opens on a right-hand page; blank pages,
%%                the separator sheets and the cardboard sheets are inserted
%%                and are not counted in the page numbering.
%%   digital      soft copy: no blank pages, no separator or cardboard sheets.
%%   nocover      leave out the hard cover pages (front, inside, back); print
%%                the cover with sampul.tex instead.
%%   noseparator  leave out the separator sheet in front of each chapter.
%%   nokarton     leave out the blank cardboard sheets after the front cover
%%                and before the back cover.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pens-thesis}[2026/11/18 v2.0 PENS Buku Tesis S2 (unofficial)]

% ---------------------------------------------------------------------------
% Options
% ---------------------------------------------------------------------------
\newif\ifpens@print   \pens@printtrue
\newif\ifpens@cover   \pens@covertrue
\newif\ifpens@sep     \pens@septrue
\newif\ifpens@karton  \pens@kartontrue

\DeclareOption{print}{\pens@printtrue}
\DeclareOption{digital}{\pens@printfalse}
\DeclareOption{nocover}{\pens@coverfalse}
\DeclareOption{separator}{\pens@septrue}
\DeclareOption{noseparator}{\pens@sepfalse}
\DeclareOption{nokarton}{\pens@kartonfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\ifpens@print\else\pens@sepfalse\pens@kartonfalse\fi

% The guide uses the same margins on every page (left 40 mm, right 30 mm),
% so the class is one-sided; right-hand pages are handled by this class.
\LoadClass[a4paper,12pt,oneside,openany,fleqn]{book}

% ---------------------------------------------------------------------------
% Packages
% ---------------------------------------------------------------------------
% Fonts. The guide was written in Word with Times New Roman (body) and
% Calibri (page numbers). With XeLaTeX/LuaLaTeX the class uses Times New
% Roman or its metric clone Liberation Serif, so lines break exactly where
% Word breaks them. With pdfLaTeX it falls back to a Times clone (newtx or
% TeX Gyre Termes), whose letters are about 1% narrower.
\RequirePackage{iftex}
\newcommand{\pens@pnfont}{\fontsize{11}{13}\selectfont}
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \IfFileExists{newtxtext.sty}{%
    \RequirePackage{newtxtext}%
    \RequirePackage{newtxmath}%
  }{%
    \RequirePackage{mathptmx}%
    \IfFileExists{tgtermes.sty}{\RequirePackage{tgtermes}}{}%
  }
  \IfFileExists{lmodern.sty}{\renewcommand{\ttdefault}{lmtt}}{}
  % Carlito is a metric-compatible clone of Calibri
  \IfFileExists{carlito.sty}{%
    \RequirePackage{carlito}%
    \renewcommand{\pens@pnfont}{\carlito\fontsize{11}{13}\selectfont}%
  }{}
\else
  \IfFileExists{newtxmath.sty}{\RequirePackage{newtxmath}}{\RequirePackage{mathptmx}}
  \RequirePackage[no-math]{fontspec}
  % Word sets text without kerning and without fi/fl ligatures
  \defaultfontfeatures{Kerning=Off,Ligatures={TeX,NoCommon}}
  \IfFontExistsTF{Times New Roman}{\setmainfont{Times New Roman}}{%
    \IfFontExistsTF{Liberation Serif}{\setmainfont{Liberation Serif}}{%
      \setmainfont{TeX Gyre Termes}}}
  \IfFontExistsTF{Calibri}{\newfontfamily\pens@calibri{Calibri}}{%
    \IfFontExistsTF{Carlito}{\newfontfamily\pens@calibri{Carlito}}{%
      \let\pens@calibri\rmfamily}}
  \renewcommand{\pens@pnfont}{\pens@calibri\fontsize{11}{13}\selectfont}
\fi
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{graphicx}
\RequirePackage[table]{xcolor}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{indentfirst}
\RequirePackage{titlesec}
\RequirePackage[titles]{tocloft}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{etoolbox}
\RequirePackage{atbegshi}
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
\definecolor{pensseparator}{RGB}{218,238,243}

% ---------------------------------------------------------------------------
% Page layout: A4, left 40 mm, right 30 mm, top 30 mm, bottom 30 mm.
% Page number baseline 17.8 mm above the bottom edge, centred on the text.
% ---------------------------------------------------------------------------
\geometry{a4paper,left=40mm,right=30mm,top=30mm,bottom=30mm,
  headheight=0pt,headsep=0pt,footskip=12.2mm}

% "Spasi 1.5" as in Word: 1.5 x 1.15 x 12 pt = 20.7 pt between baselines.
\setstretch{1.4276}
\setlength{\parindent}{10mm}
\setlength{\parskip}{0pt}
\raggedbottom
% Indonesian text is hyphenated with English patterns (no babel): allow some
% extra inter-word stretch so lines never run into the margin.
\setlength{\emergencystretch}{3em}
% Word does not hyphenate: words are never split at the end of a line.
\hyphenpenalty=10000
% Word's widow/orphan control: never a single line of a paragraph alone at
% the top or bottom of a page.
\widowpenalty=10000 \clubpenalty=10000
% Word may start a page with an equation
\predisplaypenalty=0
\linepenalty=5000


% Word moves a word to the next line when the line is exactly full; a
% 0.1 mm tolerance reproduces that (invisible in print).
\setlength{\rightskip}{0pt}
\AtBeginDocument{\addtolength{\hsize}{-0.1mm}\addtolength{\linewidth}{-0.1mm}}
% Word never shrinks inter-word spaces when justifying; switch off the
% shrinkability of the text fonts so lines break where Word breaks them.
\newcommand{\pens@noshrink}{\fontdimen4\font=\z@}
\AtBeginDocument{%
  \begingroup
  \normalfont\pens@noshrink \bfseries\pens@noshrink \itshape\pens@noshrink
  \normalfont\itshape\pens@noshrink
  \fontsize{10}{12}\selectfont\pens@noshrink \bfseries\pens@noshrink
  \normalfont\fontsize{10}{12}\selectfont\itshape\pens@noshrink
  \endgroup}

\renewcommand{\ps@plain}{%
  \let\@oddhead\@empty\let\@evenhead\@empty
  \def\@oddfoot{\hfil{\pens@pnfont\thepage}\hfil}%
  \let\@evenfoot\@oddfoot}
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
\newcommand{\pens@institusi@title}{Politeknik Elektronika Negeri Surabaya}
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
\newcommand{\pens@logosep}{figures/logo-pens-separator.png}

\newcommand{\judul}[1]{\renewcommand{\pens@judul}{#1}}
\newcommand{\judulinggris}[1]{\renewcommand{\pens@judulen}{#1}}
\newcommand{\penulis}[1]{\renewcommand{\pens@penulis}{#1}}
\newcommand{\nrp}[1]{\renewcommand{\pens@nrp}{#1}}
\newcommand{\programstudi}[1]{\renewcommand{\pens@programstudi}{#1}}
\newcommand{\pascasarjana}[1]{\renewcommand{\pens@pascasarjana}{#1}}
\newcommand{\institusi}[1]{\renewcommand{\pens@institusi}{#1}}
\newcommand{\institusikalimat}[1]{\renewcommand{\pens@institusi@title}{#1}}
\newcommand{\gelar}[1]{\renewcommand{\pens@gelar}{#1}}
\newcommand{\tahun}[1]{\renewcommand{\pens@tahun}{#1}}
\newcommand{\kota}[1]{\renewcommand{\pens@kota}{#1}}
\newcommand{\tanggalpernyataan}[1]{\renewcommand{\pens@tanggal}{#1}}
% \logo{colour logo}{grayscale logo}[separator symbol]
\newcommand{\logo}[2]{\renewcommand{\pens@logo}{#1}\renewcommand{\pens@logogray}{#2}}
\newcommand{\logopemisah}[1]{\renewcommand{\pens@logosep}{#1}}
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

\AtBeginDocument{\hypersetup{pdftitle={\pens@judul},pdfauthor={\pens@penulis}}}

% Font helper without the 1.5 stretch (cover pages, approval page)
\newcommand{\pens@fs}[1]{\linespread{1}\fontsize{#1}{\dimexpr#1pt*115/100\relax}\selectfont}

% ---------------------------------------------------------------------------
% Physical pages, right-hand pages and uncounted pages
% ---------------------------------------------------------------------------
% \pens@phys counts the pages already shipped out. The next page is a
% right-hand page when that number is even.
\newcount\pens@phys
\AtBeginShipout{\global\advance\pens@phys\@ne}

% A page that is not counted in the page numbering (#1 = its content)
\newcommand{\pens@uncountedpage}[1]{%
  \clearpage
  \begingroup
    \edef\thepage{x\the\numexpr\pens@phys+1\relax}% unique hyperref anchor
    \thispagestyle{empty}#1\null
    \clearpage
  \endgroup
  \addtocounter{page}{-1}}

% Continue on a right-hand page (print), inserting an uncounted blank page
\newcommand{\pens@clearrecto}{%
  \clearpage
  \ifpens@print\ifodd\pens@phys\pens@uncountedpage{}\fi\fi}

% Separator sheet ("halaman pemisah"): both sides light blue with staggered
% rows of the PENS symbol in teal; nothing else is written on it.
\newcommand{\pens@drawpattern}{%
  \begin{tikzpicture}[remember picture,overlay]
    \fill[pensseparator] (current page.south west) rectangle (current page.north east);
    \foreach \r in {0,...,9} {\foreach \c in {0,...,5} {
      \pgfmathsetmacro{\pens@sx}{(mod(\r,2)==0 ? 18.6 : 33.2) + 29.2*\c}
      \pgfmathsetmacro{\pens@sy}{26.3 + 25.7*\r}
      \node[anchor=north west,inner sep=0pt]
        at ([xshift=\pens@sx mm,yshift=-\pens@sy mm]current page.north west)
        {\includegraphics[width=12.3mm]{\pens@logosep}};}}
  \end{tikzpicture}}
\newcommand{\pens@separatorsheet}{%
  \pens@uncountedpage{\pens@drawpattern}%
  \pens@uncountedpage{\pens@drawpattern}}

% Blank cardboard sheet ("kertas karton"): two uncounted blank pages
\newcommand{\pens@kartonsheet}{%
  \ifpens@karton\pens@uncountedpage{}\pens@uncountedpage{}\fi}

% Every \chapter / \chapter* opens on a right-hand page. In the main and back
% matter (chapters, Daftar Pustaka, Lampiran) the separator sheet comes first.
\newif\ifpens@front \pens@fronttrue
\newcommand{\pens@chapterbreak}{%
  \pens@clearrecto
  \ifpens@front\else\ifpens@sep\pens@separatorsheet\fi\fi}
\AtBeginDocument{\pretocmd{\chapter}{\pens@chapterbreak}{}%
  {\ClassError{pens-thesis}{Cannot patch \string\chapter}{}}}
\g@addto@macro\mainmatter{\global\pens@frontfalse}
% Daftar Pustaka and Lampiran carry no page number
\g@addto@macro\backmatter{\global\pens@frontfalse\pagestyle{empty}%
  \let\ps@plain\ps@empty}

% ---------------------------------------------------------------------------
% Chapter and section headings
% ---------------------------------------------------------------------------
% Chapter: "BAB n" / TITLE, 14 pt bold, upper case, centred; first baseline
% 34.8 mm from the top edge; 3 blank lines (1.5 spacing) before the text.
\titleformat{\chapter}[display]
  {\centering\bfseries\fontsize{14}{17}\selectfont}
  {\chaptertitlename\ \thechapter}{0pt}{\MakeUppercase}
\titleformat{name=\chapter,numberless}[block]
  {\centering\bfseries\fontsize{14}{17}\selectfont}{}{0pt}{\MakeUppercase}
\newlength{\pens@chapbefore}\setlength{\pens@chapbefore}{-8.15mm}
\newlength{\pens@chapafter}\setlength{\pens@chapafter}{22.4mm}
\titlespacing*{\chapter}{0pt}{\pens@chapbefore}{\pens@chapafter}

% Section: "1.1" + 5 spaces + TITLE, 12 pt bold upper case;
% one blank line before and after.
\titleformat{\section}[hang]
  {\normalsize\bfseries}{\thesection}{5.3mm}{\MakeUppercase}
\titlespacing*{\section}{0pt}{20.7pt}{20.7pt}
% Subsection: "1.1.1" + 5 spaces + Title, 12 pt bold
\titleformat{\subsection}[hang]
  {\normalsize\bfseries}{\thesubsection}{5.3mm}{}
\titlespacing*{\subsection}{0pt}{20.7pt}{20.7pt}
% Deeper levels: unnumbered bold italic
\titleformat{\subsubsection}[hang]{\normalsize\bfseries\itshape}{}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{20.7pt}{20.7pt}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}

% ---------------------------------------------------------------------------
% Table of contents, list of figures, list of tables
% ---------------------------------------------------------------------------
\renewcommand{\cftdotsep}{1.5}
\renewcommand{\cftchapdotsep}{\cftnodots}
\renewcommand{\cftchappresnum}{}
\setlength{\cftchapindent}{0pt}
\setlength{\cftchapnumwidth}{5mm}
\setlength{\cftsecindent}{5mm}
\setlength{\cftsecnumwidth}{10mm}
\setlength{\cftsubsecindent}{15mm}
\setlength{\cftsubsecnumwidth}{12.5mm}
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftsubsecfont}{\normalfont}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
% Front-matter entries: bold, bold page number, no gap.
\newcommand{\pens@tocfront}{%
  \renewcommand{\cftchapfont}{\bfseries}%
  \renewcommand{\cftchappagefont}{\bfseries}%
  \setlength{\cftbeforechapskip}{0pt}}
% Chapter entries: blank line before, bold title, normal page number.
\newcommand{\pens@tocmain}{%
  \renewcommand{\cftchapfont}{\bfseries}%
  \renewcommand{\cftchappagefont}{\normalfont}%
  \setlength{\cftbeforechapskip}{20.7pt}}
% Back-matter entries: blank line before the first one only.
\newcommand{\pens@tocback}{\setlength{\cftbeforechapskip}{0pt}}
\pens@tocfront
% Chapter and section titles appear in upper case in the TOC
\let\pens@oldl@section\l@section
\renewcommand{\l@section}[2]{\pens@oldl@section{\MakeUppercase{#1}}{#2}}
\let\pens@oldl@chapter\l@chapter
\renewcommand{\l@chapter}[2]{\pens@oldl@chapter{\MakeUppercase{#1}}{#2}}
\g@addto@macro\mainmatter{\addtocontents{toc}{\protect\pens@tocmain}}

% List of figures / tables: "Gambar 3.1" then the title 25 mm from the margin
\renewcommand{\cftfigpresnum}{\figurename\ }
\renewcommand{\cfttabpresnum}{\tablename\ }
\setlength{\cftfignumwidth}{25mm}
\setlength{\cfttabnumwidth}{25mm}
\setlength{\cftfigindent}{0pt}
\setlength{\cfttabindent}{0pt}
\setlength{\cftbeforefigskip}{0pt}
\setlength{\cftbeforetabskip}{0pt}
% No extra space between the chapters in the list of figures / tables
\patchcmd{\@starttoc}{\makeatletter}{\makeatletter\def\addvspace##1{}}{}{}

% Front-matter pages listed in the TOC
\newcommand{\pens@tocentry}[1]{%
  \phantomsection\addcontentsline{toc}{chapter}{#1}}
\newcommand{\pens@tocentrynopage}[1]{%
  \addtocontents{toc}{\protect\contentsline{chapter}{#1}{}{}}}

\newcommand{\daftarisi}{\pens@clearrecto\pens@tocentry{DAFTAR ISI}\tableofcontents}
\newcommand{\daftargambar}{\pens@clearrecto\pens@tocentry{DAFTAR GAMBAR}\listoffigures}
\newcommand{\daftartabel}{\pens@clearrecto\pens@tocentry{DAFTAR TABEL}\listoftables}

% Unnumbered chapter that appears in the TOC
\newcommand{\babtanpanomor}[1]{\chapter*{#1}\pens@tocentry{#1}}

% ---------------------------------------------------------------------------
% Figures, tables, equations
% ---------------------------------------------------------------------------
% Caption "Gambar 3.1. Keterangan" / "Tabel 3.1. Keterangan": centred, bold.
% Figure captions go below the figure, table captions above the table.
\captionsetup{font={normalsize,bf},labelsep=period,justification=centering,
  singlelinecheck=false,skip=6.3pt}
\captionsetup[table]{position=top,skip=5.7pt}
% One blank line above and below figures and tables
\newlength{\pens@floatsep}\setlength{\pens@floatsep}{28.5pt}
\newlength{\pens@floatback}\setlength{\pens@floatback}{8pt}
\setlength{\intextsep}{\pens@floatsep}
\setlength{\textfloatsep}{\pens@floatsep}
\setlength{\floatsep}{\pens@floatsep}
\AtEndEnvironment{figure}{\par\vspace{-\pens@floatback}}
\AtEndEnvironment{table}{\par\vspace{-\pens@floatback}}
% A heading right after a figure/table: the blank line below the float and
% the blank line above the heading are one and the same (as in Word).
\newif\ifpens@afterfloat
\AfterEndEnvironment{figure}{\global\pens@afterfloattrue}
\AfterEndEnvironment{table}{\global\pens@afterfloattrue}
\AddToHook{para/begin}{\global\pens@afterfloatfalse}
\newcommand{\pens@headingafterfloat}{%
  \ifpens@afterfloat\ifvmode\vskip-28.1pt\kern\z@\fi\global\pens@afterfloatfalse\fi}
\AtBeginDocument{%
  \pretocmd{\section}{\pens@headingafterfloat}{}{}%
  \pretocmd{\subsection}{\pens@headingafterfloat}{}{}}
% Table rows 7.5 mm high, cell padding 1.9 mm as in Word
\renewcommand{\arraystretch}{1.44}
\setlength{\tabcolsep}{1.9mm}

% \sumber{...}: source of a quoted figure/table, centred, 10 pt
\newcommand{\sumber}[1]{%
  \par\vspace{2.3mm}{\centering\fontsize{10}{12}\selectfont Sumber: #1\par}}
% \headrow: shaded, bold header row of a table
\newcommand{\headrow}{\rowcolor{penstablehead}\global\col@sep=\dimexpr\tabcolsep-0.4pt\relax}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\RequirePackage{ragged2e}
\newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}
\setlength{\arrayrulewidth}{0.5pt}

% Equations: left, indented 10 mm, number right-aligned and bold, one blank
% line above and below.
\setlength{\mathindent}{10mm}
\def\tagform@#1{\maketag@@@{\bfseries(\ignorespaces#1\unskip\@@italiccorr)}}
\renewcommand{\eqref}[1]{\textup{\ref{#1}}}
\AtBeginDocument{%
  \setlength{\abovedisplayskip}{14.7pt}%
  \setlength{\belowdisplayskip}{14.7pt}%
  \setlength{\abovedisplayshortskip}{14.7pt}%
  \setlength{\belowdisplayshortskip}{11.9pt}}

% Lists: number at the margin, text 7.5 mm in, no extra space
\setlist{nosep}
\setlist[enumerate]{label=\arabic*.,leftmargin=7.5mm,labelwidth=7.5mm,
  labelsep=0pt,align=left}
\setlist[itemize]{leftmargin=7.5mm,labelwidth=7.5mm,labelsep=0pt,align=left}

% ---------------------------------------------------------------------------
% Quotations
% ---------------------------------------------------------------------------
% Short direct quotation (1-2 lines): "italic text" followed by \cite
\newcommand{\kutipan}[1]{``\textit{#1}''}
% Long direct quotation (> 2 lines): separate paragraph, 10 pt, left/right
% margin 10 mm, enclosed in double quotes, citation after it:
%   \begin{kutipanpanjang}[\cite{key}] ... \end{kutipanpanjang}
\newlength{\pens@quoteskip}\setlength{\pens@quoteskip}{7.6mm}
\newenvironment{kutipanpanjang}[1][]
  {\par\def\pens@quotecite{#1}%
   \list{}{\leftmargin=10mm\rightmargin=10mm\listparindent=0pt\itemindent=0pt
     \topsep=\pens@quoteskip\partopsep=0pt\parsep=0pt\itemsep=0pt}%
   \item\relax\fontsize{10}{12}\selectfont``\ignorespaces}
  {\unskip''\ifx\pens@quotecite\@empty\else~\pens@quotecite\fi\endlist}

% ---------------------------------------------------------------------------
% "Sistematika Penulisan": \begin{sistematika}
%   \babsistematika{Bab 1}{Pendahuluan}{Penjelasan ...}
% \end{sistematika}
% ---------------------------------------------------------------------------
\newenvironment{sistematika}
  {\list{}{\leftmargin=15mm\labelwidth=15mm\labelsep=0pt\itemindent=0pt
     \listparindent=0pt\topsep=20.7pt\partopsep=0pt\parsep=0pt\itemsep=20.7pt
     \def\makelabel##1{\textbf{##1}\hfil}}}
  {\endlist}
\newcommand{\babsistematika}[3]{\item[#1]\textbf{#2}\par #3}

% ---------------------------------------------------------------------------
% Covers and title page (positions measured from the guide, in mm from the
% top-left corner of the page)
% ---------------------------------------------------------------------------
% \pens@at{x}{baseline}{font}{text}: one centred line at an absolute position
\newcommand{\pens@at}[5][]{%
  \node[anchor=base,inner sep=0pt,align=center,#1] at
    ([xshift=#2mm,yshift=-#3mm]pens@nw) {#4#5};}
% Thesis title (16 pt bold, upper case), may wrap onto more lines
\newcommand{\pens@titleat}[3][]{%
  \node[anchor=base,inner sep=0pt,text width=150mm,align=center,#1] at
    ([xshift=#2mm,yshift=-#3mm]pens@nw)
    {\pens@fs{16}\bfseries\MakeUppercase{\pens@judul}};}

% Front cover. #1 = TikZ coordinate of the page's top-left corner.
% White area 70 mm, yellow band 5 mm, blue area 222 mm.
\newcommand{\pens@drawfrontcover}[1]{%
  \coordinate (pens@nw) at (#1);
  \fill[pensblue] ([yshift=-75mm]pens@nw) rectangle ([xshift=210mm,yshift=-297mm]pens@nw);
  \fill[pensyellow] ([yshift=-70mm]pens@nw) rectangle ([xshift=210mm,yshift=-75mm]pens@nw);
  \node[inner sep=0pt] at ([xshift=41.5mm,yshift=-40.7mm]pens@nw)
    {\includegraphics[width=30mm,height=30mm,keepaspectratio]{\pens@logo}};
  \pens@at[text=pensblue]{172.1}{41.1}{\pens@fs{24}\bfseries}{TESIS}
  \pens@titleat[text=white]{105.7}{107.7}
  \begin{scope}[text=white]
    \pens@at{105.7}{150.4}{\pens@fs{14}\bfseries}{\pens@penulis}
    \pens@at{105.7}{156.0}{\pens@fs{14}}{NRP. \pens@nrp}
    \pens@at{105.7}{187.8}{\pens@fs{14}\bfseries}{DOSEN PEMBIMBING}
    \pens@at{105.7}{199.0}{\pens@fs{14}\bfseries}{\pens@utama}
    \ifx\pens@pendamping\@empty\else
      \pens@at{105.7}{204.7}{\pens@fs{14}\bfseries}{\pens@pendamping}\fi
    \pens@at{105.7}{256.6}{\pens@fs{16}\bfseries}{PROGRAM STUDI MAGISTER TERAPAN}
    \pens@at{105.7}{263.1}{\pens@fs{16}\bfseries}{\MakeUppercase{\pens@programstudi}}
    \pens@at{105.7}{269.6}{\pens@fs{16}\bfseries}{\MakeUppercase{\pens@pascasarjana}}
    \pens@at{105.7}{276.1}{\pens@fs{16}\bfseries}{\MakeUppercase{\pens@institusi}}
    \pens@at{105.7}{282.6}{\pens@fs{16}\bfseries}{\pens@tahun}
  \end{scope}}

% Back cover: blue. #1 = top-left corner.
\newcommand{\pens@drawbackcover}[1]{%
  \fill[pensblue] (#1) rectangle ([xshift=210mm,yshift=-297mm]#1);}

% Title page (white paper, grayscale logo, black text)
\newcommand{\pens@drawtitlepage}{%
  \coordinate (pens@nw) at (current page.north west);
  \node[inner sep=0pt] at ([xshift=56.1mm,yshift=-49.7mm]pens@nw)
    {\includegraphics[width=30mm,height=30mm,keepaspectratio]{\pens@logogray}};
  \pens@at{168.2}{52.7}{\pens@fs{24}\bfseries}{TESIS}
  \pens@titleat{110.8}{100.4}
  \pens@at{110.8}{143.1}{\pens@fs{14}\bfseries}{\pens@penulis}
  \pens@at{110.8}{148.7}{\pens@fs{14}}{NRP. \pens@nrp}
  \pens@at{110.8}{180.3}{\pens@fs{14}\bfseries}{DOSEN PEMBIMBING}
  \pens@at{110.8}{191.6}{\pens@fs{14}\bfseries}{\pens@utama}
  \ifx\pens@pendamping\@empty\else
    \pens@at{110.8}{197.4}{\pens@fs{14}\bfseries}{\pens@pendamping}\fi
  \pens@at{110.8}{242.1}{\pens@fs{14}\bfseries}{PROGRAM STUDI MAGISTER TERAPAN}
  \pens@at{110.8}{247.7}{\pens@fs{14}\bfseries}{\MakeUppercase{\pens@programstudi}}
  \pens@at{110.8}{253.4}{\pens@fs{14}\bfseries}{\MakeUppercase{\pens@pascasarjana}}
  \pens@at{110.8}{259.1}{\pens@fs{14}\bfseries}{\MakeUppercase{\pens@institusi}}
  \pens@at{110.8}{264.8}{\pens@fs{14}\bfseries}{\pens@tahun}}

% Whole-page drawing on an uncounted page
\newcommand{\pens@fullpage}[1]{%
  \pens@uncountedpage{\begin{tikzpicture}[remember picture,overlay]#1\end{tikzpicture}}}

% \halamanjudul: hard cover + inside of the cover, cardboard sheet, title page
\newcommand{\halamanjudul}{%
  \global\pens@fronttrue
  \ifpens@cover
    \pens@fullpage{\pens@drawfrontcover{current page.north west}}%
    \ifpens@print\pens@uncountedpage{}\fi
  \fi
  \pens@kartonsheet
  \pens@tocentrynopage{HALAMAN JUDUL}%
  \pens@clearrecto
  \pens@fullpage{\pens@drawtitlepage}}

% \sampulbelakang: cardboard sheet, inside of the back cover, back cover
\newcommand{\sampulbelakang}{%
  \pens@clearrecto
  \pens@kartonsheet
  \ifpens@cover
    \ifpens@print\pens@uncountedpage{}\fi
    \pens@fullpage{\pens@drawbackcover{current page.north west}}%
  \fi}

% ---------------------------------------------------------------------------
% Approval page (Halaman Pengesahan): single spacing (13.8 pt), centred on
% the page; labels start 25.4 mm from the left edge. The watermark of the
% approval sheet is printed separately and is not part of this template.
% ---------------------------------------------------------------------------
\newcommand{\pens@signrow}[3]{%
  \makebox[47.6mm][l]{#1} & : & \underline{#2} & (\hfill) \\
     &   & NIP. #3 & \\ \noalign{\vskip 4.6mm}}
\newlength{\pens@approvaltop}\setlength{\pens@approvaltop}{-9.2mm}
\newcommand{\halamanpengesahan}{%
  \pens@clearrecto
  \pens@tocentrynopage{HALAMAN PENGESAHAN}%
  \thispagestyle{empty}%
  \begingroup
  \edef\thepage{x\the\numexpr\pens@phys+1\relax}%
  \linespread{1}\fontsize{12}{13.8}\selectfont
  \setlength{\parindent}{0pt}%
  \vspace*{\pens@approvaltop}%
  \noindent\hspace*{-14.6mm}%
  \begin{minipage}[t]{160.4mm}
    \linespread{1}\fontsize{12}{13.8}\selectfont
    \centering
    {\pens@fs{14}\bfseries HALAMAN PENGESAHAN\par}
    \vspace{10.0mm}
    {\bfseries\MakeUppercase{\pens@judul}\par}
    \vspace{\baselineskip}
    Oleh:\par
    {\bfseries\pens@penulis\par NRP. \pens@nrp\par}
    \vspace{2\baselineskip}
    {\bfseries Tesis ini digunakan sebagai salah satu syarat untuk memperoleh\par
     Gelar \pens@gelar\par di\par \pens@institusi@title\par \pens@tahun\par}
    \vspace{3\baselineskip}
    {\bfseries Disetujui oleh:\par}
    \vspace{2\baselineskip}
    {\raggedright\renewcommand{\arraystretch}{1}\setlength{\tabcolsep}{6pt}%
     \begin{tabular}{@{}l@{}p{5mm}@{}p{50mm}@{}p{37.6mm}@{}}
       \pens@signrow{Pembimbing Utama}{\pens@utama}{\pens@utamanip}
       \ifx\pens@pendamping\@empty\else
         \pens@signrow{Pembimbing Pendamping}{\pens@pendamping}{\pens@pendampingnip}
       \fi
       \pens@pengujilist
     \end{tabular}\par}
    \vspace{10.6mm}
    {\bfseries Mengetahui,\par}
    \vspace{\baselineskip}
    \pens@jabatanpengesah\par \pens@institusi@title\par
    \vspace{4\baselineskip}
    \underline{\pens@pengesah}\par NIP. \pens@pengesahnip\par
  \end{minipage}\par
  \clearpage
  \endgroup
  \addtocounter{page}{-1}}

% ---------------------------------------------------------------------------
% Statement pages (first text 19.6 mm below the title)
% ---------------------------------------------------------------------------
\newcommand{\pens@signature}[1][2\baselineskip]{%
  \par\vspace{#1}%
  {\setlength{\parindent}{0pt}\leftskip=90.0mm
   \pens@kota, \pens@tanggal\par\vspace{\baselineskip}
   Yang menyatakan,\par\vspace{3\baselineskip}
   (\pens@penulis)\par}}
\newcommand{\pens@statementhead}[1]{\babtanpanomor{#1}\vspace{-10.1mm}}

\newcommand{\halamanorisinalitas}{%
  \pens@statementhead{HALAMAN PERNYATAAN ORISINALITAS}
  \noindent Dengan ini saya menyatakan bahwa bagian atau keseluruhan tesis ini:
  \begin{enumerate}[topsep=20.7pt]
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
  \pens@statementhead{HALAMAN KESEPAKATAN PUBLIKASI}
  \noindent Demi pengembangan ilmu pengetahuan, dengan ini saya menyatakan:
  \begin{enumerate}[topsep=20.7pt]
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
  \pens@signature[\baselineskip]}

% ---------------------------------------------------------------------------
% Abstract: \begin{abstrak}{kata kunci 1, kata kunci 2} ... \end{abstrak}
% ---------------------------------------------------------------------------
\newenvironment{abstrak}[1]
  {\babtanpanomor{ABSTRAK}\def\pens@keywords{#1}}
  {\par\vspace{2\baselineskip}\noindent\textbf{Kata Kunci}\par
   \vspace{\baselineskip}\noindent\textit{\pens@keywords}\par}
\newenvironment{abstract}[1]
  {\babtanpanomor{ABSTRACT}\def\pens@keywords{#1}}
  {\par\vspace{2\baselineskip}\noindent\textbf{Keywords}\par
   \vspace{\baselineskip}\noindent\textit{\pens@keywords}\par}

% Roman numbering starts at the originality statement (page i)
\newcommand{\mulaiprakata}{\pens@clearrecto\pagenumbering{roman}}

% ---------------------------------------------------------------------------
% Bibliography: "1." at the margin, text 7.5 mm in; listed in the TOC
% without page number (pens.bst)
% ---------------------------------------------------------------------------
\newcommand{\daftarpustaka}[1]{%
  \bibliographystyle{pens}%
  \bibliography{#1}}
\renewcommand{\bibnumfmt}[1]{\makebox[7.5mm][l]{#1.}}
\renewenvironment{thebibliography}[1]
  {\chapter*{\bibname}%
   \pens@tocentrynopage{DAFTAR PUSTAKA}%
   \addtocontents{toc}{\protect\pens@tocback}%
   \list{}{\labelwidth=7.5mm\leftmargin=7.5mm\labelsep=0pt
      \itemsep=0pt\parsep=0pt\topsep=0pt
      \usecounter{enumiv}\let\p@enumiv\@empty
      \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy\clubpenalty4000\@clubpenalty\clubpenalty\widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}

% Appendix: one "LAMPIRAN" page in the TOC without page number
\newcommand{\lampiran}{%
  \appendix
  \chapter*{LAMPIRAN}%
  \pens@tocentrynopage{LAMPIRAN}%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{-1}}}

\endinput
