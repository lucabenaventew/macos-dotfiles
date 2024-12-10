vim.g.rainbow_active = 1
vim.opt.guicursor = "i-ci-ve:hor30"
-- vim.cmd([[colorscheme gruvbox-material]])
local function set_colorscheme()
    local hour = os.date("*t").hour

    if hour >= 18 then
        vim.cmd("colorscheme gruvbox-material")
    else
        vim.cmd("colorscheme dawnfox")
    end
end

set_colorscheme()

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("")
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- netrw
vim.g.netrw_liststyle = 3

vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.DS_Store\|\~$]]

vim.filetype.add({
    extension = {
        tera = "html",
        ["html.tera"] = "html",
    },
})

-- Custom syntax highlighting for Tera tags
vim.cmd [[
  syntax match TeraTag "{{.*?}}"
  syntax match TeraStatement "{%.*?%}"
  highlight link TeraTag Keyword
  highlight link TeraStatement Conditional
]]
