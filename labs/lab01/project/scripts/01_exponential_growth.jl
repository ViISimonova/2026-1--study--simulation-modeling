using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
using DataFrames

# 1. Функция модели (дифференциальное уравнение)
# du - скорость изменения, u - текущее значение, p - параметр (альфа)
function exponential_growth!(du, u, p, t)
    α = p
    du[1] = α * u[1]
end

# 2. Параметры модели
u0 = [1.0]          # начальная популяция (в виде вектора)
α = 0.3             # скорость роста
tspan = (0.0, 10.0) # время моделирования от 0 до 10

# 3. Решение задачи
prob = ODEProblem(exponential_growth!, u0, tspan, α)
sol = solve(prob, Tsit5(), saveat=0.1) # Tsit5() — это стандартный численный метод

# 4. Визуализация
plot(sol, label="u(t)", xlabel="Время t", ylabel="Популяция u",
     title="Экспоненциальный рост (α = $α)", lw=2, legend=:topleft)

# 5. Сохранение графика
savefig(plotsdir("exponential_growth_α=$α.png"))

# 6. Работа с данными (таблица)
df = DataFrame(t=sol.t, u=first.(sol.u))
println("Первые 5 строк результатов:")
println(first(df, 5))

# 7. Расчет аналитического показателя
u_final = last(sol.u)[1]
doubling_time = log(2) / α
println("\nАналитическое время удвоения: ", round(doubling_time; digits=2))