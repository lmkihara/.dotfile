-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- check if lspconfig is installed
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<Leader>dk', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>dj', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

vim.opt.completeopt = {"menu", "menuone", "noselect"}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})


local server = {'jedi_language_server', 'bashls', 'ansiblels', 'terraformls', 'dockerls', 'gopls'}

require'lspconfig'.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

require'lspconfig'.jedi_language_server.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

require'lspconfig'.bashls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

require'lspconfig'.ansiblels.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
        ansible = {
            ansible = {
                path = "ansible"
            },
            ansibleLint = {
                enabled = true,
                path = "ansible-lint"
            },
            python = {
                interpreterPath = "python3"
            }
        }
    }
}

require'lspconfig'.terraformls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

require'lspconfig'.dockerls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
