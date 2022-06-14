vim.cmd [[
try
  colorscheme cplex
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
