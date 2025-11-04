return {
  -- 1. Ensure tofu-ls is installed by mason.nvim
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "terraform-ls" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable terraformls (set to false to properly disable)
        terraformls = false,
        -- Configure terraform-ls for OpenTofu
        -- terraform-ls works with OpenTofu as they share the same protocol
        terraform_ls = {
          cmd = { "terraform-ls", "serve" },
          filetypes = { "terraform", "tf", "tfvars" },
          root_dir = require("lspconfig.util").root_pattern(".terraform", ".git"),
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        tofu_fmt = {
          command = "tofu",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        terraform = { "tofu_fmt" },
        tf = { "tofu_fmt" },
        tfvars = { "tofu_fmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Initialize linters table if it doesn't exist
      opts.linters = opts.linters or {}
      opts.linters_by_ft = opts.linters_by_ft or {}

      -- Define the "tofu_validate" linter with a custom parser
      opts.linters.tofu_validate = {
        cmd = "tofu",
        args = { "validate", "-json" },
        stdin = false,
        ignore_exitcode = true,
        parser = function(output, bufnr)
          local diagnostics = {}

          -- Parse the JSON output
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or not decoded then
            return diagnostics
          end

          -- Check if validation was successful
          if decoded.valid == true then
            return diagnostics
          end

          -- Process diagnostics array
          if decoded.diagnostics then
            for _, diag in ipairs(decoded.diagnostics) do
              local severity = vim.diagnostic.severity.ERROR
              if diag.severity == "warning" then
                severity = vim.diagnostic.severity.WARN
              elseif diag.severity == "error" then
                severity = vim.diagnostic.severity.ERROR
              end

              -- Extract range information
              local range = diag.range or {}
              local start_pos = range.start or {}
              local end_pos = range["end"] or {}

              table.insert(diagnostics, {
                lnum = (start_pos.line or 1) - 1, -- nvim-lint uses 0-based line numbers
                end_lnum = (end_pos.line or start_pos.line or 1) - 1,
                col = (start_pos.column or 1) - 1, -- nvim-lint uses 0-based columns
                end_col = (end_pos.column or start_pos.column or 1) - 1,
                severity = severity,
                message = diag.summary or "Validation error",
                source = "tofu",
              })
            end
          end

          return diagnostics
        end,
      }

      -- Set the linter for terraform filetypes
      opts.linters_by_ft.terraform = { "tofu_validate" }
      opts.linters_by_ft.tf = { "tofu_validate" }

      return opts
    end,
  },
}
