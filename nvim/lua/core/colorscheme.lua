vim.cmd('set background=dark')

local status, _ = pcall(vim.cmd, "colorscheme gruvbox8")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end
