using Plots

# parâmetros físicos
x = range(-10, 10, length=400)
k = 2.0
sigma = 1.0
v = 1.0

# função do pacote de onda
function wave_packet(x,t)
    exp.(-(x .- v*t).^2 ./ (2*sigma^2)) .* cos.(k*(x .- v*t))
end

anim = @animate for t in range(0,10,length=120)
    
    y = wave_packet(x,t)

    plot(
        x,
        y,
        ylim=(-1,1),
        xlabel="x",
        ylabel="ψ(x,t)",
        title="Wave Packet Simulation",
        legend=false
    )
end

gif(anim,"wave_packet.gif",fps=30)

# salvar imagem final
y = wave_packet(x,10)

plot(
    x,
    y,
    ylim=(-1,1),
    xlabel="x",
    ylabel="ψ(x,t)",
    title="Final State"
)

savefig("wave_packet.png")