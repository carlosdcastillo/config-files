return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Simple plugins can be specified as strings
  -- use '9mm/vim-closer'

use {
'nvim-treesitter/nvim-treesitter',
run = ':TSUpdate'
}

use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}
use {'nvim-telescope/telescope-z.nvim'}

use "savq/melange"

use {'kyazdani42/nvim-web-devicons'}
use { 'feline-nvim/feline.nvim' }

use {'neovim/nvim-lspconfig'}

use {"terrortylor/nvim-comment"}

use 'folke/tokyonight.nvim'
use "EdenEast/nightfox.nvim"
end)
