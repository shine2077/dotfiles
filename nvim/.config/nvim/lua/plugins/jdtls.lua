-- 在 lua/plugins/jdtls.lua 中
return {
  "mfussenegger/nvim-jdtls",
  opts = function(_, opts)
    -- 将 lombok 路径加入 jdtls 启动命令
    local lombok_path = "/home/sun/.m2/repository/org/projectlombok/lombok/1.18.30/lombok-1.18.30.jar"
    table.insert(opts.cmd, "--jvm-arg=-javaagent:" .. lombok_path)
  end,
}
