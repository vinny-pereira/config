" CONFIG {{{

set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set cursorline
set cursorcolumn
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pyc,*.exe,*.flv,*.img,*.xlsx
set background=dark


" }}}

" Mappings {{{
let mapleader = "\\"

nnoremap <leader>\ ``
nnoremap <silent> <leader>p :%w !lp<CR>
nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>
nnoremap n nzz
nnoremap N Nzz
nnoremap Y y$
nnoremap <C-t> :Files<CR>
nnoremap <f7> :RG<CR>
inoremap jj <esc>
nnoremap <c-d> yyp
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-
nnoremap <c-left> <c-w>>
nnoremap <c-right> <c-w><
nnoremap <c-k><c-v> :vsplit<CR>
nnoremap <c-k><c-h> :split<CR>
nnoremap <c-e> :Explore<CR>

" }}}

" OmniSharp Config {{{
"
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlighting = 3

" IDE0010: Populate switch - display in ALE as `Info`
" IDE0055: Fix formatting - display in ALE as `Warning` style error
" CS8019: Duplicate of IDE0005
" RemoveUnnecessaryImportsFixable: Generic warning that an unused using exists
let g:OmniSharp_diagnostic_overrides = {
\ 'IDE0010': {'type': 'I'},
\ 'IDE0055': {'type': 'W', 'subtype': 'Style'},
\ 'CS8019': {'type': 'None'},
\ 'RemoveUnnecessaryImportsFixable': {'type': 'None'}
\}

let g:OmniSharp_diagnostic_exclude_paths = [
\ 'obj\\',
\ '[Tt]emp\\',
\ '\.nuget\\',
\ '\<AssemblyInfo\.cs\>'
\]

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" }}}

"" Plugins {{{

call plug#begin()
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'OmniSharp/omnisharp-vim'
	Plug 'dense-analysis/ale'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'tailwindlabs/tailwindcss-intellisense'
    Plug 'onsails/lspkind-nvim'
    Plug 'kylechui/nvim-surround'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'ellisonleao/gruvbox.nvim'
call plug#end()

" }}}

" Ale {{{
"
let g:ale_linters = {
\'cs': ['OmniSharp'],
\ 'go': ['golangci-lint'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}

let g:ale_fixers = {
\ 'cs': ['OmniSharp'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_go_golangci_lint_executable = expand('$HOME/.local/bin/golangci-lint')

" }}}

" VIMSCRIPT {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "vimdoc", "lua", "python", "cpp", "html", "javascript", "go" }, 
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
local nvim_lsp = require'lspconfig'
nvim_lsp.gopls.setup{}
nvim_lsp.html.setup{}

local configs = require'lspconfig/configs'
if not nvim_lsp.tailwindcss then
    configs.tailwindcss = {
        default_config = {
            cmd = { 'tailwindcss-intellisense', '--stdio' },
            filetypes = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue' },
            root_dir = nvim_lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'tailwind.config.svelte', 'tailwind.config.json', '.git'),
            settings = {},
        },
    }
end

nvim_lsp.tailwindcss.setup{}
nvim_lsp.tsserver.setup{}

local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
    },
    formatting = {
    format = function(entry, vim_item)
      vim_item.kind = require('lspkind').presets.default[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        vsnip = "[VSnip]",
      })[entry.source.name]
      return vim_item
    end
  },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

require("nvim-surround").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, lsp in ipairs({'tsserver', 'gopls', 'html', 'cssls'}) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
  }
end

EOF
" }}}

colorscheme gruvbox
