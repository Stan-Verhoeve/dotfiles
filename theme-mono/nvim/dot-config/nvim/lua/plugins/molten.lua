--[[
  Molten: Jupyter Notebook Integration

  Connects nvim to a running Jupyter kernel for interactive computing.
  Images are disabled (Alacritty does not support inline image protocols).

  Usage:
    :MoltenInit        - attach a kernel (prompts to choose)
    :MoltenEvaluateLine        - run current line
    :MoltenEvaluateVisual      - run visual selection
    :MoltenReevaluateCell      - re-run current cell
    :MoltenDelete              - delete current cell output
    :MoltenHideOutput          - hide output window
    :MoltenShowOutput          - show output window

  Dependencies (install via pip):
    pip install pynvim jupyter_client
--]]

return {
  "benlubas/molten-nvim",
  version = "^1.0.0",
  build = ":UpdateRemotePlugins",
  ft = { "python" },
  init = function()
    -- Disable image provider (Alacritty does not support inline images)
    vim.g.molten_image_provider = "none"

    -- Output window settings
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = true
    vim.g.molten_wrap_output = true

    -- Show virtual text with cell status
    vim.g.molten_virt_text_output = true
    vim.g.molten_virt_lines_off_by_1 = true
  end,
  config = function()
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = "Molten: " .. desc, silent = true })
    end

    map("<leader>mi", ":MoltenInit<CR>",                    "[I]nit kernel")
    map("<leader>ml", ":MoltenEvaluateLine<CR>",            "Evaluate [L]ine")
    map("<leader>mr", ":MoltenReevaluateCell<CR>",          "[R]e-evaluate cell")
    map("<leader>md", ":MoltenDelete<CR>",                  "[D]elete cell output")
    map("<leader>mh", ":MoltenHideOutput<CR>",              "[H]ide output")
    map("<leader>ms", ":MoltenShowOutput<CR>",              "[S]how output")

    vim.keymap.set("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>",
      { desc = "Molten: Evaluate [V]isual", silent = true })
  end,
}
