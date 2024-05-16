return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        { "j-hui/fidget.nvim",       opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            nmap("<leader>r", vim.lsp.buf.rename, "Rename")
            nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
            nmap("gd", vim.lsp.buf.definition, "Go to definition")
            nmap("gR", require("telescope.builtin").lsp_references, "Get references in a telescope list")
            nmap("gr", function()
                vim.lsp.buf.references(nil, {
                    on_list = function(options)
                        vim.fn.setqflist({}, " ", options)
                        vim.api.nvim_command("cfirst")
                    end,
                })
            end, "Get references in a quickfix list")
            nmap("gI", vim.lsp.buf.implementation, "Go to implementation")
            nmap("gt", vim.lsp.buf.type_definition, "Go to type definition")
            nmap("K", vim.lsp.buf.hover, "Hover Documentation")
            nmap("H", vim.lsp.buf.signature_help, "Signature Help")
            nmap("<leader>cf", vim.lsp.buf.format, "Format file")
            nmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
        end

        local servers = {
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
            rust_analyzer = {},
            html = {},
            sqlls = {},
            helm_ls = {},
            zls = {},
            golangci_lint_ls = {},
            clangd = {},
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

        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = "",
                },
            },
        })

        local null_ls = require("null-ls")

        local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }
        local stylua_root_files = { "stylua.toml", ".stylua.toml" }

        local root_has_file = function(files)
            return function(utils)
                return utils.root_has_file(files)
            end
        end

        local opts = {
            prettier_formatting = {
                condition = root_has_file(prettier_root_files),
            },
            stylua_formatting = {
                condition = root_has_file(stylua_root_files),
            },
        }

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier.with(opts.prettier_formatting),
                null_ls.builtins.formatting.stylua.with(opts.stylua_formatting),
                null_ls.builtins.formatting.clang_format,
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

        -- auto format
        local format_is_enabled = true
        vim.api.nvim_create_user_command("ToggleAutoFormat", function()
            format_is_enabled = not format_is_enabled
            print("Setting autoformatting to: " .. tostring(format_is_enabled))
        end, {})

        local _augroups = {}
        local get_augroup = function(client)
            if not _augroups[client.id] then
                local group_name = "kickstart-lsp-format-" .. client.name
                local id = vim.api.nvim_create_augroup(group_name, { clear = true })
                _augroups[client.id] = id
            end

            return _augroups[client.id]
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
            callback = function(args)
                local client_id = args.data.client_id
                local client = vim.lsp.get_client_by_id(client_id)
                local bufnr = args.buf

                if not client.server_capabilities.documentFormattingProvider then
                    return
                end

                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = get_augroup(client),
                    buffer = bufnr,
                    callback = function()
                        if not format_is_enabled then
                            return
                        end

                        vim.lsp.buf.format({
                            async = false,
                            filter = function(c)
                                return c.id == client.id
                            end,
                        })
                    end,
                })
            end,
        })
    end,
}
