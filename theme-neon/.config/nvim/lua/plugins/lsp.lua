--[[
  LSP Configuration

  Language Server Protocol (LSP) setup with:
  - nvim-lspconfig: LSP client configuration
  - mason.nvim: LSP server installer
  - mason-lspconfig.nvim: Bridge between mason and lspconfig
  - mason-tool-installer: Install LSP tools automatically
  - fidget.nvim: LSP status updates

  Usage: :LspInfo to see active LSP servers
--]]

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp", -- for completion capabilities
    },
    config = function()
      -- Diagnostic configuration
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      -- Get LSP capabilities from blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- LSP servers to configure
      local servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            -- Add your GSL include path here:
            "--extra-arg=-I/nix/store/0hjm57cxss3rypj1c8q5s68ahns07x8i-gsl-2.7.1-dev/include",
          },
        },
        basedpyright = {},
        texlab = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Tools to ensure are installed
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { "stylua" }) -- Lua formatter
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      -- Set up lspconfig handlers
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })

      -- LSP attach autocommand - sets up keymaps when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Rename
          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Code actions
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

          -- References
          map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Implementation
          map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Definition
          map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- Declaration
          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- Document symbols
          map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

          -- Workspace symbols
          map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

          -- Type definition
          map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

          -- Helper: check if client supports method
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- Document highlights (highlight word under cursor)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- Toggle inlay hints
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })
    end,
  },
}
