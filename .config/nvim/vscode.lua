vim.cmd [[packadd packer.nvim]]
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-commentary'
  use 'machakann/vim-sandwich'
end)

vim.o.clipboard = 'unnamedplus'

if vim.g.vscode then
  vim.api.nvim_set_keymap('n', 'gd',
    "<cmd>call VSCodeCall('editor.action.revealDefinition')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', 'gi',
    "<cmd>call VSCodeCall('editor.action.goToImplementation')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', 'gr',
    "<cmd>call VSCodeCall('editor.action.goToReferences')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', 'gn',
    "<cmd>call VSCodeCall('editor.action.rename')<CR>",
    {noremap = true, silent = true})

  vim.api.nvim_set_keymap('n', ']d',
    "<cmd>call VSCodeCall('editor.action.marker.next')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '[d',
    "<cmd>call VSCodeCall('editor.action.marker.prev')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '[c',
    "<cmd>call VSCodeCall('workbench.action.editor.previousChange')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', ']c',
    "<cmd>call VSCodeCall('workbench.action.editor.nextChange')<CR>",
    {noremap = true, silent = true})

  vim.api.nvim_set_keymap('n', '<C-h>',
    "<cmd>call VSCodeCall('workbench.action.focusPreviousGroup')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<C-j>',
    "<cmd>call VSCodeCall('workbench.action.focusBelowGroup')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<C-k>',
    "<cmd>call VSCodeCall('workbench.action.focusAboveGroup')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<C-l>',
    "<cmd>call VSCodeCall('workbench.action.focusNextGroup')<CR>",
    {noremap = true, silent = true})

  vim.api.nvim_set_keymap('n', ']t',
    "<cmd>call VSCodeCall('workbench.action.nextEditorInGroup')<CR>",
    {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '[t',
    "<cmd>call VSCodeCall('workbench.action.previousEditorInGroup')<CR>",
    {noremap = true, silent = true})

  vim.api.nvim_set_keymap('n', 'gt',
    "<cmd>call VSCodeCall('workbench.action.terminal.toggleTerminal')<CR>",
    {noremap = true, silent = true})
end
