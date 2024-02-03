local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
    nmap("<leader>f", function()
        vim.lsp.buf.format()
    end, "[F]ormat file")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gR", require("telescope.builtin").lsp_references, "[G]oto Telescope [R]eferences")
    nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>cD", vim.lsp.buf.type_definition, "[C]ode Type [D]efinition")
    nmap("<leader>csd", require("telescope.builtin").lsp_document_symbols, "[C]ode [S]ymbols: [D]ocument")
    nmap("<leader>csw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[C]ode [S]ymbols: [W]orkspace")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("H", vim.lsp.buf.signature_help, "Signature Help")
end

local servers = {
    clangd = {},
    gopls = {},
    terraformls = {
        cmd = { "terraform-ls", "serve" },
    },
    ruff_lsp = {},
    pyright = {
        python = {
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "off",
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
    tsserver = {},
    rust_analyzer = {},
    html = {},
    sqlls = {},
    helm_ls = {},
    golangci_lint_ls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- tfvars bugfix for terraform-ls. This is a temporary fix for neovim 0.9.0
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.tfvars,*.tf",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(bufnr, "filetype", "terraform")
    end,
})

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("mason").setup()

null_ls = require("null-ls")
null_ls.setup()

local get_python_virtual_env = function()
    return os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
end

require("mason-null-ls").setup({
    ensure_installed = {
        -- python
        "mypy",
        "black",
        -- lua
        "stylua",
        -- markdown
        "prettier",
        -- shell
        "shellcheck",
        "shfmt",
    },
    automatic_installation = false,
    handlers = {
        -- Prevent the automatic setup of mason-null-ls and do
        -- the setup manually in the null-ls block below.
        mypy = function(source_name, methods)
            null_ls.builtins.diagnostics.mypy.with({
                extra_args = function()
                    local virtual = get_python_virtual_env()
                    return { "--python-executable", virtual .. "/bin/python3" }
                end,
            })
        end,
    },
})

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})

local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})
require("luasnip.loaders.from_vscode").lazy_load()

---@diagnostic disable-next-line: missing-fields
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})
