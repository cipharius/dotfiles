# Lf launcher

provide-module lf %{
  require-module connect
  require-module connect-lf

  declare-option -hidden str lf_params %{-command "set preview!; set ratios 1"}

  declare-user-mode lf-mode
  map global -docstring 'Open in pwd' \
    lf-mode w ': lf %opt{lf_params}<a-!><ret>'
  map global -docstring 'Open in file dir' \
    lf-mode d ': lf %opt{lf_params} %sh{dirname $kak_buffile}<a-!><ret>'
  map global -docstring 'Open in git root' \
    lf-mode p ': lf %opt{lf_params} %sh{git rev-parse --show-toplevel}<a-!><ret>'
}
