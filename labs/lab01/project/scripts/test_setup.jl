using DrWatson
@quickactivate "project"
println("✅ Проект активирован: ", projectdir())

## Список пакетов для проверки
packages = [
    "DrWatson", "DifferentialEquations", "Plots", 
    "DataFrames", "CSV", "JLD2", "Literate", 
    "IJulia", "BenchmarkTools", "Quarto"
]

println("\nПроверка пакетов:")
for pkg in packages
    try
        # Попытка загрузки пакета
        eval(Meta.parse("using $pkg"))
        println(" ✓ $pkg")
    catch e
        println(" ✗ $pkg: Ошибка загрузки")
    end
end

## Проверка структуры путей
println("\nСтруктура проекта:")
println(" Корень:  ", projectdir())
println(" Данные:  ", datadir())
println(" Скрипты: ", srcdir())
println(" Графики: ", plotsdir())