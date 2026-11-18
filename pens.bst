% pens.bst -- BibTeX style for the PENS master's thesis book (Buku Tesis S2).
%
% Numeric labels [1], [2], ... with the list sorted by author, then year and
% title, as required by "Panduan Buku Tesis S2" (Program Pascasarjana PENS).
% Every element is separated by a comma and the entry ends with a period.
% As in the guide, titles are bold; journal / seminar / publisher of a book /
% university / media name / internet address are italic:
%
%   article        Pengarang1, Pengarang2, Judul Makalah, Nama Jurnal,
%                  Vol. xx, No. yy, Hal. aa-bb, Penerbit, Tahun.
%   inproceedings  Pengarang1, Pengarang2, Judul Makalah, Nama Seminar,
%                  Tempat, Hal. aa-bb, Tahun.
%   book           Pengarang1, Pengarang2, Judul Buku, Penerbit, Edisi xx, Tahun.
%   phdthesis /    Nama Mahasiswa, Judul, Tesis/Disertasi, Perguruan Tinggi,
%   mastersthesis  Tahun.
%   newspaper      Penulis, Judul Tulisan, Nama Media, Tanggal, Edisi, Tahun.
%   (misc with howpublished + month/edition)
%   online / misc  Penulis, Judul Tulisan, Nama Situs, URL, Diakses tanggal
%   with url       ..., Tahun.
%
% The sorting machinery is adapted from the standard `plain' style by
% Howard Trickey and Oren Patashnik (renamed as its licence requires).

ENTRY
  { address author booktitle chapter edition editor howpublished
    institution journal key month note number organization pages
    publisher school series title type url urldate volume year }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence }
INTEGERS { nameptr namesleft numnames len }
STRINGS { s t }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {embolden}
{ duplicate$ empty$
    { pop$ "" }
    { "{\bfseries " swap$ * "}" * }
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "\/}" * }
  if$
}

% --- output ----------------------------------------------------------------

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { write$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

% --- field formatting ------------------------------------------------------

% Names: full names, separated by commas ("Nama_Pengarang1, Nama_Pengarang2")
FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
        { t "others" =
            { " dkk." * }
            { ", " * t * }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { editor empty$
        { organization field.or.null }
        { editor format.names " (Ed.)" * }
      if$
    }
    { author format.names }
  if$
}

FUNCTION {format.title}
{ title field.or.null embolden }

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "-" *
              t #2 global.max$ substring$ 't :=
            }
            { "-" *
                { t #1 #1 substring$ "-" = }
                { t #2 global.max$ substring$ 't := }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {format.volume}
{ volume empty$
    { "" }
    { "Vol.~" volume * }
  if$
}

FUNCTION {format.number}
{ number empty$
    { "" }
    { "No.~" number * }
  if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { "Hal.~" pages n.dashify * }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { "Edisi " edition * }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { "{\itshape\url{" url * "}}" * }
  if$
}

FUNCTION {format.urldate}
{ urldate empty$
    { "" }
    { "Diakses tanggal " urldate * }
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$ type }
  if$
}

FUNCTION {format.publisher}
{ publisher empty$
    { organization empty$
        { institution field.or.null }
        { organization }
      if$
    }
    { publisher }
  if$
}

% --- entry types -----------------------------------------------------------

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  journal emphasize "journal" output.check
  format.volume output
  format.number output
  format.pages output
  publisher field.or.null output
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  booktitle emphasize "booktitle" output.check
  address output
  format.pages output
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {book}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  format.publisher emphasize output
  format.edition output
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  chapter empty$ 'skip$ { "Bab~" chapter * output } if$
  format.pages output
  format.publisher output
  format.edition output
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  booktitle emphasize "booktitle" output.check
  format.pages output
  format.publisher output
  format.edition output
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  "Tesis" format.thesis.type output.nonnull
  school emphasize "school" output.check
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  "Disertasi" format.thesis.type output.nonnull
  school emphasize "school" output.check
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  type empty$ 'skip$ { type number empty$ 'skip$ { " " * number * } if$ output } if$
  institution "institution" output.check
  address output
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {manual}
{ output.bibitem
  format.authors output
  format.title "title" output.check
  format.publisher emphasize output
  format.edition output
  year output
  note output
  fin.entry
}

% Public media (newspaper, magazine) and online sources
FUNCTION {misc}
{ output.bibitem
  format.authors output
  format.title "title" output.check
  url empty$
    { howpublished emphasize output }
    { howpublished output }
  if$
  month output
  format.edition output
  format.url output
  format.urldate output
  year output
  note output
  fin.entry
}

FUNCTION {online} { misc }
FUNCTION {electronic} { misc }
FUNCTION {www} { misc }
FUNCTION {newspaper} { misc }

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  note output
  year output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  format.authors output
  format.title "title" output.check
  address output
  format.publisher output
  year "year" output.check
  note output
  fin.entry
}

FUNCTION {booklet} { misc }

FUNCTION {default.type} { misc }

MACRO {jan} {"Januari"}
MACRO {feb} {"Februari"}
MACRO {mar} {"Maret"}
MACRO {apr} {"April"}
MACRO {may} {"Mei"}
MACRO {jun} {"Juni"}
MACRO {jul} {"Juli"}
MACRO {aug} {"Agustus"}
MACRO {sep} {"September"}
MACRO {oct} {"Oktober"}
MACRO {nov} {"November"}
MACRO {dec} {"Desember"}

READ

% --- sorting: author, year, title (from plain.bst) --------------------------

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {presort}
{ author empty$
    { editor empty$
        { organization empty$
            { key empty$
                { title field.or.null sort.format.title }
                { key sortify }
              if$
            }
            { organization sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
  "    " *
  year field.or.null sortify *
  "    " *
  title field.or.null sort.format.title *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{" longest.label * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
