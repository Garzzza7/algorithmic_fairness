// values
#let formula_size = 22pt
#let text_size = 14pt
#let image_size = 85%
#let column_height = 5%
#let chapter_size = 15pt
#let date_size = 8pt
#let line_size = 100%
#let header_size = 10pt
#let header_alignment = center
#let chapter_alignment = center
#let margin_x = 1.0cm
#let margin_y = 1.0cm

// symbols
#let plusminus = " ± "
#let circumpunct = " ⊙ "

// functions
#let eval(expr, size: 200%) = $lr(#expr|, size: #size)$

// date
#let today = datetime.today()
#let last_compiled = {
  $
    #align(chapter_alignment)[
      \ #set text(size: date_size)
      = *
      Last compiled on #today.display()
      *
      \ #line(length: line_size)
    ]
  $
}

// chapter footer
#let chapter(title) = {
  $
    #align(chapter_alignment)[
      \ #set text(size: chapter_size)
      = *
      #title
      *
      \ #line(length: line_size)
    ]
  $
}
