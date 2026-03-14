using Plots

# Backend gráfico
gr()

# ==============================
# Parâmetros da onda
# ==============================

A = 1.0
k = 2π
ω = 2π

# ==============================
# Função de onda
# ==============================

function psi(x, t)
    return A * sin(k*x - ω*t)
end

# ==============================
# Domínio espacial
# ==============================

x = range(0, 10, length=300)

# ==============================
# Animação
# ==============================

anim = @animate for t in range(0, 4, length=100)

    y = psi.(x, t)

    plot(
        x,
        y,
        ylim=(-1.2,1.2),
        linewidth=3,
        xlabel="x",
        ylabel="ψ(x,t)",
        title="Propagação da Função de Onda",
        label="ψ(x,t)",
        color=:blue
    )

end

# ==============================
# Salvar animação
# ==============================

gif(anim, "onda_animada.gif", fps=30)

println("Animação salva como: onda_animada.gif")