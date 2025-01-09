(lang dune 3.16)

(name blog)

(source
 (github sabine/blog))

(authors
 "Sabine")

(maintainers "Sabine")

(generate_opam_files true)

(package
 (allow_empty)
 (name blog)
 (synopsis "My blog")
 (description
  "This package generates the HTML pages found at https://parsing.life")
 (depends
  (ocaml
   (>= 4.14.0))
  dune
  bos
  fpath
  tailwindcss
  html_of_jsx
  mlx
  fmt
  (cmarkit
   (>= 0.2.0))
  ppx_deriving_yaml
  ))

(dialect
 (name mlx)
 (implementation
  (extension mlx)
  (merlin_reader mlx)
  (preprocess
   (run mlx-pp %{input-file}))))
