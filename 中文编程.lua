

-- ============================================
-- 模块1: 核心中文API和语法糖
-- ============================================

-- 设置模块命名空间
中文编程 = {}

-- 1.1 基础函数别名（兼容性保留）
中文编程.局部 = function(t, val) return val end  -- 语法糖占位
中文编程.函数 = function(...) return function(...) return ... end end
中文编程.结束 = nil  -- 作为语法标记使用

-- 1.2 输出输入
中文编程.打印 = print
中文编程.输出 = print
中文编程.输入 = io.read
中文编程.格式化输出 = function(fmt, ...)
    print(string.format(fmt, ...))
end

-- 1.3 类型转换和检查
中文编程.转为数字 = tonumber
中文编程.转为字符串 = tostring
中文编程.获取类型 = type
中文编程.是数字 = function(v) return type(v) == "number" end
中文编程.是字符串 = function(v) return type(v) == "string" end
中文编程.是表格 = function(v) return type(v) == "table" end
中文编程.是函数 = function(v) return type(v) == "function" end
中文编程.是布尔值 = function(v) return type(v) == "boolean" end

-- 1.4 数学函数
中文编程.数学 = {}
中文编程.数学.绝对值 = math.abs
中文编程.数学.平方根 = math.sqrt
中文编程.数学.幂 = math.pow
中文编程.数学.指数 = math.exp
中文编程.数学.对数 = math.log
中文编程.数学.正弦 = math.sin
中文编程.数学.余弦 = math.cos
中文编程.数学.正切 = math.tan
中文编程.数学.反正弦 = math.asin
中文编程.数学.反余弦 = math.acos
中文编程.数学.反正切 = math.atan
中文编程.数学.向上取整 = math.ceil
中文编程.数学.向下取整 = math.floor
中文编程.数学.四舍五入 = function(n, 位数)
    位数 = 位数 or 0
    local 乘数 = 10 ^ 位数
    return math.floor(n * 乘数 + 0.5) / 乘数
end
中文编程.数学.最大值 = math.max
中文编程.数学.最小值 = math.min
中文编程.数学.随机数 = math.random
中文编程.数学.圆周率 = math.pi

-- 1.5 字符串操作
中文编程.字符串 = {}
中文编程.字符串.大写 = string.upper
中文编程.字符串.小写 = string.lower
中文编程.字符串.反转 = string.reverse
中文编程.字符串.长度 = string.len
中文编程.字符串.查找 = string.find
中文编程.字符串.匹配 = string.match
中文编程.字符串.截取 = string.sub
中文编程.字符串.替换 = string.gsub
中文编程.字符串.重复 = string.rep
中文编程.字符串.格式化 = string.format

中文编程.字符串.分割 = function(str, 分隔符)
    分隔符 = 分隔符 or ","
    local 结果 = {}
    for 段 in string.gmatch(str, "[^"..分隔符.."]+") do
        table.insert(结果, 段)
    end
    return 结果
end

中文编程.字符串.连接 = function(字符串表, 分隔符)
    分隔符 = 分隔符 or ""
    return table.concat(字符串表, 分隔符)
end

中文编程.字符串.去首尾空格 = function(str)
    return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

中文编程.字符串.是否以开头 = function(str, 前缀)
    return string.sub(str, 1, #前缀) == 前缀
end

中文编程.字符串.是否以结尾 = function(str, 后缀)
    return #后缀 == 0 or string.sub(str, -#后缀) == 后缀
end

-- ============================================
-- 模块2: 中文数据结构
-- ============================================

-- 2.1 列表（增强数组）
中文编程.列表 = {}

function 中文编程.列表.新建(...)
    local 列表实例 = {...}
    
    -- 设置列表方法
    setmetatable(列表实例, {
        __index = 中文编程.列表,
        __add = function(a, b) return 中文编程.列表.合并(a, b) end,
        __tostring = function(self) return 中文编程.列表.转字符串(self) end,
        __len = function(self) return #self end,
        __call = function(self, 索引) return self[索引] end
    })
    
    return 列表实例
end

function 中文编程.列表.追加(列表, 值)
    table.insert(列表, 值)
    return 列表
end

function 中文编程.列表.插入(列表, 位置, 值)
    table.insert(列表, 位置, 值)
    return 列表
end

function 中文编程.列表.删除(列表, 位置)
    return table.remove(列表, 位置)
end

function 中文编程.列表.弹出(列表)
    return table.remove(列表)
end

function 中文编程.列表.长度(列表)
    return #列表
end

function 中文编程.列表.合并(列表1, 列表2)
    local 结果 = 中文编程.列表.新建()
    for _, v in ipairs(列表1) do 结果:追加(v) end
    for _, v in ipairs(列表2) do 结果:追加(v) end
    return 结果
end

function 中文编程.列表.切片(列表, 开始, 结束)
    开始 = 开始 or 1
    结束 = 结束 or #列表
    local 结果 = 中文编程.列表.新建()
    for i = math.max(1, 开始), math.min(#列表, 结束) do
        结果:追加(列表[i])
    end
    return 结果
end

function 中文编程.列表.转字符串(列表, 分隔符)
    分隔符 = 分隔符 or ", "
    local 字符串表 = {}
    for _, v in ipairs(列表) do
        table.insert(字符串表, tostring(v))
    end
    return "[" .. table.concat(字符串表, 分隔符) .. "]"
end

function 中文编程.列表.包含(列表, 值)
    for _, v in ipairs(列表) do
        if v == 值 then return true end
    end
    return false
end

function 中文编程.列表.查找(列表, 值)
    for i, v in ipairs(列表) do
        if v == 值 then return i end
    end
    return nil
end

-- 2.2 字典（增强表格）
中文编程.字典 = {}

function 中文编程.字典.新建(初始表)
    local 字典实例 = 初始表 or {}
    
    setmetatable(字典实例, {
        __index = 中文编程.字典,
        __tostring = function(self) return 中文编程.字典.转字符串(self) end
    })
    
    return 字典实例
end

function 中文编程.字典.设置(字典, 键, 值)
    字典[键] = 值
    return 字典
end

function 中文编程.字典.获取(字典, 键, 默认值)
    local 值 = 字典[键]
    if 值 == nil then return 默认值 end
    return 值
end

function 中文编程.字典.删除(字典, 键)
    local 值 = 字典[键]
    字典[键] = nil
    return 值
end

function 中文编程.字典.包含键(字典, 键)
    return 字典[键] ~= nil
end

function 中文编程.字典.键列表(字典)
    local 列表 = 中文编程.列表.新建()
    for k in pairs(字典) do
        列表:追加(k)
    end
    return 列表
end

function 中文编程.字典.值列表(字典)
    local 列表 = 中文编程.列表.新建()
    for _, v in pairs(字典) do
        列表:追加(v)
    end
    return 列表
end

function 中文编程.字典.转字符串(字典)
    local 条目 = {}
    for k, v in pairs(字典) do
        table.insert(条目, string.format("%s: %s", tostring(k), tostring(v)))
    end
    return "{" .. table.concat(条目, ", ") .. "}"
end

-- ============================================
-- 模块3: 函数式编程工具
-- ============================================

-- 3.1 高阶函数
中文编程.映射 = function(表, 变换函数)
    local 结果 = 中文编程.列表.新建()
    for _, 值 in ipairs(表) do
        结果:追加(变换函数(值))
    end
    return 结果
end

中文编程.过滤 = function(表, 条件函数)
    local 结果 = 中文编程.列表.新建()
    for _, 值 in ipairs(表) do
        if 条件函数(值) then
            结果:追加(值)
        end
    end
    return 结果
end

中文编程.归约 = function(表, 初始值, 归约函数)
    local 结果 = 初始值
    for _, 值 in ipairs(表) do
        结果 = 归约函数(结果, 值)
    end
    return 结果
end

中文编程.遍历 = function(表, 操作函数)
    for 索引, 值 in ipairs(表) do
        操作函数(值, 索引)
    end
end

中文编程.全部满足 = function(表, 条件函数)
    for _, 值 in ipairs(表) do
        if not 条件函数(值) then
            return false
        end
    end
    return true
end

中文编程.任意满足 = function(表, 条件函数)
    for _, 值 in ipairs(表) do
        if 条件函数(值) then
            return true
        end
    end
    return false
end

中文编程.查找元素 = function(表, 条件函数)
    for _, 值 in ipairs(表) do
        if 条件函数(值) then
            return 值
        end
    end
    return nil
end

-- 3.2 函数组合和柯里化
中文编程.组合 = function(...)
    local 函数表 = {...}
    return function(...)
        local 结果 = {...}
        for i = #函数表, 1, -1 do
            结果 = {函数表[i](unpack(结果))}
        end
        return unpack(结果)
    end
end

中文编程.柯里化 = function(函数, 参数数量)
    参数数量 = 参数数量 or 2
    local 收集参数 = {}
    
    local function 柯里化函数(...)
        for _, v in ipairs({...}) do
            table.insert(收集参数, v)
        end
        
        if #收集参数 >= 参数数量 then
            local 结果 = 函数(unpack(收集参数))
            收集参数 = {}
            return 结果
        else
            return 柯里化函数
        end
    end
    
    return 柯里化函数
end

-- ============================================
-- 模块4: 实用工具和语法糖
-- ============================================

-- 4.1 中文流程控制（语法糖）
中文编程.如果 = function(条件, 真分支, 假分支)
    if 条件 then
        return 真分支()
    elseif 假分支 then
        return 假分支()
    end
end

中文编程.当 = function(条件, 循环体)
    while 条件() do
        循环体()
    end
end

中文编程.循环 = function(起始, 结束, 步长, 循环体)
    步长 = 步长 or 1
    for i = 起始, 结束, 步长 do
        循环体(i)
    end
end

中文编程.遍历表 = function(表, 循环体)
    for 键, 值 in pairs(表) do
        循环体(键, 值)
    end
end

-- 4.2 错误处理
中文编程.尝试 = function(尝试代码)
    return {
        捕获 = function(错误处理)
            local 成功, 错误信息 = pcall(尝试代码)
            if not 成功 then
                return 错误处理(错误信息)
            end
        end,
        最终 = function(最终代码)
            local 成功, 错误信息 = pcall(尝试代码)
            if not 成功 then
                -- 记录错误但不处理
            end
            最终代码()
            if not 成功 then
                error(错误信息)
            end
        end
    }
end

-- 4.3 时间和日期
中文编程.时间 = {}
中文编程.时间.现在 = os.time
中文编程.时间.日期 = os.date
中文编程.时间.等待 = function(秒数)
    local 开始时间 = os.time()
    while os.time() - 开始时间 < 秒数 do
        -- 空循环等待
    end
end

中文编程.时间.格式化 = function(格式, 时间戳)
    时间戳 = 时间戳 or os.time()
    return os.date(格式, 时间戳)
end

-- 4.4 文件操作
中文编程.文件 = {}

中文编程.文件.读取 = function(文件路径)
    local 文件句柄, 错误信息 = io.open(文件路径, "r")
    if not 文件句柄 then
        return nil, 错误信息
    end
    local 内容 = 文件句柄:read("*a")
    文件句柄:close()
    return 内容
end

中文编程.文件.写入 = function(文件路径, 内容)
    local 文件句柄, 错误信息 = io.open(文件路径, "w")
    if not 文件句柄 then
        return false, 错误信息
    end
    文件句柄:write(内容)
    文件句柄:close()
    return true
end

中文编程.文件.追加 = function(文件路径, 内容)
    local 文件句柄, 错误信息 = io.open(文件路径, "a")
    if not 文件句柄 then
        return false, 错误信息
    end
    文件句柄:write(内容)
    文件句柄:close()
    return true
end

中文编程.文件.存在 = function(文件路径)
    local 文件句柄 = io.open(文件路径, "r")
    if 文件句柄 then
        文件句柄:close()
        return true
    end
    return false
end

-- 4.5 系统操作
中文编程.系统 = {}
中文编程.系统.执行命令 = os.execute
中文编程.系统.退出 = os.exit
中文编程.系统.环境变量 = os.getenv

-- ============================================
-- 模块5: 便捷导入和使用
-- ============================================

-- 5.1 全局导入函数
function 中文编程.启用全局模式()
    -- 将常用函数注入全局环境
    local 全局 = _G
    
    -- 核心函数
    全局["打印"] = 中文编程.打印
    全局["输出"] = 中文编程.输出
    全局["输入"] = 中文编程.输入
    
    -- 类型转换
    全局["转为数字"] = 中文编程.转为数字
    全局["转为字符串"] = 中文编程.转为字符串
    全局["获取类型"] = 中文编程.获取类型
    
    -- 数据结构
    全局["列表"] = 中文编程.列表.新建
    全局["字典"] = 中文编程.字典.新建
    
    -- 函数式工具
    全局["映射"] = 中文编程.映射
    全局["过滤"] = 中文编程.过滤
    全局["归约"] = 中文编程.归约
    全局["遍历"] = 中文编程.遍历
    
    -- 流程控制（语法糖）
    全局["如果"] = 中文编程.如果
    全局["当"] = 中文编程.当
    全局["循环"] = 中文编程.循环
    
    -- 数学函数（常用）
    全局["数学"] = 中文编程.数学
    全局["字符串"] = 中文编程.字符串
    全局["文件"] = 中文编程.文件
    全局["时间"] = 中文编程.时间
    
    return "中文编程环境已启用"
end

-- 5.2 模块导出
function 中文编程.导入为(别名)
    _G[别名] = 中文编程
    return 中文编程
end

-- 5.3 快速开始
function 中文编程.快速开始()
    print([[
    ===================================
    中文编程 DSL - 快速开始
    ===================================
    
    1. 启用全局模式:
       中文编程.启用全局模式()
    
    2. 使用中文函数:
       列表 = 列表(1, 2, 3, 4, 5)
       偶数 = 过滤(列表, 函数(x) 返回 x % 2 == 0 结束)
       打印(偶数)
    
    3. 或使用命名空间:
       局部 cp = 中文编程
       cp.打印("你好，世界！")
    
    4. 查看文档:
       打印(中文编程.帮助())
    ]])
end

-- 5.4 帮助文档
function 中文编程.帮助()
    return [[
    中文编程 DSL 使用说明
    
    主要模块:
      中文编程.数学     - 数学函数
      中文编程.字符串   - 字符串操作
      中文编程.列表     - 列表数据结构
      中文编程.字典     - 字典数据结构
      中文编程.文件     - 文件操作
      中文编程.时间     - 时间日期
    
    函数式编程:
      映射(表, 函数)    - 对每个元素应用函数
      过滤(表, 条件)    - 过滤满足条件的元素
      归约(表, 初始值, 函数) - 累积计算
    
    快速开始:
      中文编程.启用全局模式()
      中文编程.快速开始()
    ]]
end

-- 5.5 版本信息
中文编程.版本 = "1.0.0"
中文编程.作者 = "AI助手"
中文编程.日期 = "2024年"

-- ============================================
-- 模块6: 示例和测试（演示代码）
-- ============================================

-- 6.1 内置示例函数
function 中文编程.演示()
    print("=== 中文编程 DSL 演示 ===")
    
    -- 启用全局模式方便演示
    中文编程.启用全局模式()
    
    -- 示例1: 基础使用
    print("\n1. 基础数学运算:")
    局部 半径 = 5
    局部 面积 = 数学.圆周率 * 半径 * 半径
    打印(string.format("半径 %.1f 的圆面积: %.2f", 半径, 面积))
    
    -- 示例2: 列表操作
    print("\n2. 列表操作:")
    局部 数字列表 = 列表(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    打印("原始列表:", 数字列表)
    
    局部 平方列表 = 映射(数字列表, 函数(x) 返回 x * x 结束)
    打印("平方列表:", 平方列表)
    
    局部 偶数列表 = 过滤(数字列表, 函数(x) 返回 x % 2 == 0 结束)
    打印("偶数列表:", 偶数列表)
    
    局部 总和 = 归约(数字列表, 0, 函数(累积, 值) 返回 累积 + 值 结束)
    打印("列表总和:", 总和)
    
    -- 示例3: 字符串操作
    print("\n3. 字符串操作:")
    局部 文本 = "  你好，世界！这是一个测试字符串。  "
    打印("原始文本:", 文本)
    打印("去空格后:", 字符串.去首尾空格(文本))
    打印("大写:", 字符串.大写(文本))
    打印("分割:", 字符串.分割("苹果,香蕉,橙子,葡萄"))
    
    -- 示例4: 字典操作
    print("\n4. 字典操作:")
    局部 学生 = 字典({
        姓名 = "张三",
        年龄 = 18,
        成绩 = {数学=90, 语文=85, 英语=88}
    })
    打印("学生信息:", 学生)
    打印("学生姓名:", 学生:获取("姓名"))
    
    -- 示例5: 文件操作
    print("\n5. 文件操作演示:")
    局部 测试文件 = "测试文件.txt"
    文件.写入(测试文件, "这是一个测试文件\n第二行内容")
    打印("文件已写入")
    
    如果(文件.存在(测试文件), 函数()
        局部 内容 = 文件.读取(测试文件)
        打印("文件内容:", 内容)
    结束)
    
    print("\n=== 演示结束 ===")
end

-- 启用全局模式（只启用一次）
if not _G.中文编程已启用 then
    中文编程.启用全局模式()
    _G.中文编程已启用 = true
end

-- 返回模块
return 中文编程
