vim.keymap.set('n', '<leader>xx', vim.diagnostic.open_float, { desc = "Open diagnostics for current line" })
vim.keymap.set('n', '<leader>xl', vim.diagnostic.setloclist, { desc = "Open location list for diagnostics" })
vim.keymap.set('n', 'T', vim.diagnostic.goto_prev)
vim.keymap.set('n', 't', vim.diagnostic.goto_next)

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
    nmap('<leader>f', function() vim.lsp.buf.format() end, '[F]ormat file')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto Telescope [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>cD', vim.lsp.buf.type_definition, '[C]ode Type [D]efinition')
    nmap('<leader>csd', require('telescope.builtin').lsp_document_symbols, '[C]ode [S]ymbols: [D]ocument')
    nmap('<leader>csw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[C]ode [S]ymbols: [W]orkspace')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
end

local servers = {
    clangd        = {},
    gopls         = {},
    pyright       = {},
    terraformls   = {},
    tsserver      = {},
    rust_analyzer = {},
    html          = {},
    sqlls         = {},
    helm_ls       = {},
    lua_ls        = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()

vim.keymap.set('n', '<leader>sm', ':Mason<CR>', { desc = "[S]etup [M]ason" })

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}
require("luasnip.loaders.from_vscode").lazy_load()

---@diagnostic disable-next-line: missing-fields
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
