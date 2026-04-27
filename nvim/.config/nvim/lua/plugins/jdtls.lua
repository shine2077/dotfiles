return {
  "mfussenegger/nvim-jdtls",
  opts = function(_, opts)
    local lombok_pattern = vim.fn.expand("~/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar")
    local matches = vim.fn.glob(lombok_pattern, false, true)

    if #matches == 0 then
      return
    end

    table.sort(matches)
    table.insert(opts.cmd, "--jvm-arg=-javaagent:" .. matches[#matches])
  end,
}
