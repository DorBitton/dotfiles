local leet_arg = "leetcode.nvim"

return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = "Leet",
    lazy = leet_arg ~= vim.fn.argv(0, -1),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      arg = leet_arg,
      lang = "golang",
      cn = {
        enabled = false,
      },
      storage = {
        home = vim.fn.expand("~/projects/leetcode-solutions/solutions"),
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },
      plugins = {
        non_standalone = true,
      },
      logging = true,
      injector = {
        ["golang"] = {
          before = "package main",
        },
      },
      hooks = {
        ["leave"] = {
          function()
            local script = vim.fn.expand("~/projects/leetcode-solutions/scripts/track.py")
            if vim.uv.fs_stat(script) then
              vim.fn.jobstart({ "python3", script })
            end
          end,
        },
      },
    },
  },
}
